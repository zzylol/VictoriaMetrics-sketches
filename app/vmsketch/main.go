package vmsketch

import (
	"fmt"
	"sync"
	"sync/atomic"
	"time"

	"github.com/VictoriaMetrics/metrics"
	"github.com/zzylol/VictoriaMetrics-sketches/app/vmselect/searchutils"
	"github.com/zzylol/VictoriaMetrics-sketches/lib/cgroup"
	"github.com/zzylol/VictoriaMetrics-sketches/lib/logger"
	"github.com/zzylol/VictoriaMetrics-sketches/lib/querytracer"
	"github.com/zzylol/VictoriaMetrics-sketches/lib/storage"
	"github.com/zzylol/VictoriaMetrics-sketches/lib/syncwg"
	"github.com/zzylol/promsketch"
)

var gomaxprocs = cgroup.AvailableCPUs()

var defaultMaxWorkersPerQuery = func() int {
	// maxWorkersLimit is the maximum number of CPU cores, which can be used in parallel
	// for processing an average query, without significant impact on inter-CPU communications.
	const maxWorkersLimit = 32

	n := gomaxprocs
	if n > maxWorkersLimit {
		n = maxWorkersLimit
	}
	return n
}()

// MaxWorkers returns the maximum number of concurrent goroutines, which can be used by RunParallel()
func MaxWorkers() int {
	return defaultMaxWorkersPerQuery
}

var (
	seriesReadPerQuery = metrics.NewHistogram(`vmsketch_series_read_per_query`)
)

// SketchCache is a rollup cache with sketches.
//
// Every sketch call must be wrapped into WG.Add(1) ... WG.Done()
// for proper graceful shutdown when Stop is called.
var SketchCache *promsketch.VMSketches

// WG must be incremented before Storage call.
//
// Use syncwg instead of sync, since Add is called from concurrent goroutines.
var WG syncwg.WaitGroup

// Init initializes vmsketch.
func Init() {
	SketchCache = promsketch.NewVMSketches()
}

// Stop stops the vmsketch
func Stop() {
	logger.Infof("gracefully closing the sketch cache")
	startTime := time.Now()
	WG.WaitAndBlock()
	SketchCache.Stop()
	logger.Infof("successfully stopped the sketch cache in %.3f seconds", time.Since(startTime).Seconds())
}

// RegisterMetricNames registers all the metrics from mrs in the storage.
func RegisterMetricNames(qt *querytracer.Tracer, mrs []storage.MetricRow) {
	WG.Add(1)
	SketchCache.RegisterMetricNames(mrs)
	WG.Done()
}

// RegisterMetricNames registers all the metrics from mrs in the storage.
func RegisterMetricNameFuncName(mn *storage.MetricName, funcName string, window int64, item_window int64) error {
	WG.Add(1)
	err := SketchCache.RegisterMetricNames(mn, funcName, window, item_window)
	WG.Done()
	return err
}

// DeleteSeries deletes series matching tfss.
//
// Returns the number of deleted series.
func DeleteSeries(qt *querytracer.Tracer, tfss []*storage.TagFilters) (int, error) {
	WG.Add(1)
	n, err := SketchCache.DeleteSeries(tfss)
	WG.Done()
	return n, err
}

// SearchMetricNames returns metric names for the given tfss on the given tr.
func SearchMetricNames(qt *querytracer.Tracer, tfss []*storage.TagFilters, tr storage.TimeRange, maxMetrics int, deadline uint64) ([]string, error) {
	WG.Add(1)
	metricNames, err := SketchCache.SearchMetricNames(tfss, tr, maxMetrics, deadline)
	WG.Done()
	return metricNames, err
}

// SearchMetricNames returns metric names for the given tfss on the given tr.
func SearchMetricNameFuncName(mn *storage.MetricName, funcName string) bool {
	WG.Add(1)
	lookup := SketchCache.LookupMetricNameFuncName(mn, funcName)
	WG.Done()
	return lookup
}

// GetSeriesCount returns the number of time series in the storage.
func GetSeriesCount(deadline uint64) (uint64, error) {
	WG.Add(1)
	n := SketchCache.GetSeriesCount(deadline)
	WG.Done()
	return n, nil
}

// Result is a single timeseries result.
//
// Search returns Result slice.
type SketchResult struct {
	MetricName storage.MetricName
	sketchIns  *promsketch.SketchInstances
}

// Results holds results returned from ProcessSearchQuery.
type SketchResults struct {
	tr         storage.TimeRange
	deadline   searchutils.Deadline
	sketchInss []SketchResult
}

// Len returns the number of results in srs.
func (srs *SketchResults) Len() int {
	return len(srs.sketchInss)
}

// Cancel cancels srs work.
func (srs *SketchResults) Cancel() {
	srs.mustClose()
}

func (srs *SketchResults) mustClose() {
	// put something to memory pool
}

type timeseriesWork struct {
	mustStop *atomic.Bool
	srs      *SketchResults
	f        func(sr *SketchResult, workerID uint) error
	err      error
}

func (tsw *timeseriesWork) do(sr *SketchResult, workerID uint) error {
	if tsw.mustStop.Load() {
		return nil
	}
	srs := tsw.srs
	if srs.deadline.Exceeded() {
		tsw.mustStop.Store(true)
		return fmt.Errorf("timeout exceeded during query execution: %s", srs.deadline.String())
	}

	if err := tsw.f(sr, workerID); err != nil {
		tsw.mustStop.Store(true)
		return err
	}
	return nil
}

func timeseriesWorker(qt *querytracer.Tracer, workChs []chan *timeseriesWork, workerID uint) {
	tmpResult := getTmpResult()

	// Perform own work at first.
	rowsProcessed := 0
	seriesProcessed := 0
	ch := workChs[workerID]
	for tsw := range ch {
		tsw.err = tsw.do(&tmpResult.rs, workerID)
		seriesProcessed++
	}
	qt.Printf("own work processed: series=%d, samples=%d", seriesProcessed, rowsProcessed)

	// Then help others with the remaining work.
	rowsProcessed = 0
	seriesProcessed = 0
	for i := uint(1); i < uint(len(workChs)); i++ {
		idx := (i + workerID) % uint(len(workChs))
		ch := workChs[idx]
		for len(ch) > 0 {
			// Do not call runtime.Gosched() here in order to give a chance
			// the real owner of the work to complete it, since it consumes additional CPU
			// and slows down the code on systems with big number of CPU cores.
			// See https://github.com/zzylol/VictoriaMetrics-sketches/issues/3966#issuecomment-1483208419

			// It is expected that every channel in the workChs is already closed,
			// so the next line should return immediately.
			tsw, ok := <-ch
			if !ok {
				break
			}
			tsw.err = tsw.do(&tmpResult.rs, workerID)

			seriesProcessed++
		}
	}
	qt.Printf("others work processed: series=%d, samples=%d", seriesProcessed, rowsProcessed)

	putTmpResult(tmpResult)
}

func getTmpResult() *result {
	v := resultPool.Get()
	if v == nil {
		v = &result{}
	}
	return v.(*result)
}

func putTmpResult(r *result) {
	resultPool.Put(r)
}

type result struct {
	rs            SketchResult
	lastResetTime uint64
}

var resultPool sync.Pool

// RunParallel runs f in parallel for all the results from srs.
//
// f shouldn't hold references to rs after returning.
// workerID is the id of the worker goroutine that calls f. The workerID is in the range [0..MaxWorkers()-1].
// Data processing is immediately stopped if f returns non-nil error.
//
// srs becomes unusable after the call to RunParallel.
func (srs *SketchResults) RunParallel(qt *querytracer.Tracer, f func(sr *SketchResult, workerID uint) error) error {
	qt = qt.NewChild("parallel process of fetched sketch instances")
	defer srs.mustClose()

	rowsProcessedTotal, err := srs.runParallel(qt, f)
	seriesProcessedTotal := len(srs.sketchInss)

	seriesReadPerQuery.Update(float64(seriesProcessedTotal))

	qt.Donef("series=%d, samples=%d", seriesProcessedTotal, rowsProcessedTotal)

	return err
}

func (srs *SketchResults) runParallel(qt *querytracer.Tracer, f func(sr *SketchResult, workerID uint) error) (int, error) {
	tswsLen := len(srs.sketchInss)
	if tswsLen == 0 {
		// Nothing to process
		return 0, nil
	}

	var mustStop atomic.Bool
	initTimeseriesWork := func(tsw *timeseriesWork, sr *SketchResult) {
		tsw.srs = srs
		tsw.f = f
		tsw.mustStop = &mustStop
	}
	maxWorkers := MaxWorkers()
	if maxWorkers == 1 || tswsLen == 1 {
		// It is faster to process time series in the current goroutine.
		var tsw timeseriesWork
		tmpResult := getTmpResult()
		rowsProcessedTotal := 0
		var err error
		for i := range srs.sketchInss {
			initTimeseriesWork(&tsw, &srs.sketchInss[i])
			err = tsw.do(&tmpResult.rs, 0)

			if err != nil {
				break
			}
		}
		putTmpResult(tmpResult)

		return rowsProcessedTotal, err
	}

	// Slow path - spin up multiple local workers for parallel data processing.
	// Do not use global workers pool, since it increases inter-CPU memory ping-poing,
	// which reduces the scalability on systems with many CPU cores.

	// Prepare the work for workers.
	tsws := make([]timeseriesWork, len(srs.sketchInss))
	for i := range srs.sketchInss {
		initTimeseriesWork(&tsws[i], &srs.sketchInss[i])
	}

	// Prepare worker channels.
	workers := len(tsws)
	if workers > maxWorkers {
		workers = maxWorkers
	}
	itemsPerWorker := (len(tsws) + workers - 1) / workers
	workChs := make([]chan *timeseriesWork, workers)
	for i := range workChs {
		workChs[i] = make(chan *timeseriesWork, itemsPerWorker)
	}

	// Spread work among workers.
	for i := range tsws {
		idx := i % len(workChs)
		workChs[idx] <- &tsws[i]
	}
	// Mark worker channels as closed.
	for _, workCh := range workChs {
		close(workCh)
	}

	// Start workers and wait until they finish the work.
	var wg sync.WaitGroup
	for i := range workChs {
		wg.Add(1)
		qtChild := qt.NewChild("worker #%d", i)
		go func(workerID uint) {
			timeseriesWorker(qtChild, workChs, workerID)
			qtChild.Done()
			wg.Done()
		}(uint(i))
	}
	wg.Wait()

	// Collect results.
	var firstErr error
	rowsProcessedTotal := 0
	for i := range tsws {
		tsw := &tsws[i]
		if tsw.err != nil && firstErr == nil {
			// Return just the first error, since other errors are likely duplicate the first error.
			firstErr = tsw.err
		}
	}
	return rowsProcessedTotal, firstErr
}

func ProcessSearchQuery(start, end int64, tagFiltesrs [][]storage.TagFilter, funcNames []string, maxMetrics int) (*SketchResults, bool) {
	return nil, false
}

// AddRows adds mrs to the sketch cache.
//
// The caller should limit the number of concurrent calls to AddRows() in order to limit memory usage.
func AddRows(mrs []storage.MetricRow) error {
	WG.Add(1)
	err := SketchCache.AddRows(mrs)
	WG.Done()
	return err
}
