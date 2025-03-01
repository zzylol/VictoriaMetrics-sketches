package common

import (
	"encoding/csv"
	"flag"
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	"github.com/zzylol/VictoriaMetrics-sketches/app/vmsketch"
	"github.com/zzylol/VictoriaMetrics-sketches/lib/storage"
)

const defaultPrecisionBits = 4

var flagvar, flagthreads int
var flagdataset, flagalgo string
var flag_sample_window int64

func init() {
	flag.IntVar(&flagvar, "numts", 1000, "number of timeseries")
	flag.StringVar(&flagdataset, "dataset", "zipf", "dataset")
	flag.Int64Var(&flag_sample_window, "sample_window", 10000, "sample window")
	flag.StringVar(&flagalgo, "algorithm", "sampling", "algorithm to test")
	flag.IntVar(&flagthreads, "numthreads", 64, "number of threads")
}

func TestVMWriteThroughPut(t *testing.T) {
	scrapeCountBatch := 2160000 // seconds, 12 hours
	num_ts := flagvar
	path := "BenchmarkCtxInsertThoughput"
	s := storage.MustOpenStorage(path, 0, 0, 0)
	defer func() {
		s.MustClose()
		if err := os.RemoveAll(path); err != nil {
			t.Fatalf("cannot remove storage at %q: %s", path, err)
		}
	}()

	var mn storage.MetricName
	metricRows := make([]storage.MetricRow, num_ts)
	mn.MetricGroup = []byte("fake_metric")
	for ts_id := 0; ts_id < num_ts; ts_id++ {
		mn.Tags = []storage.Tag{
			{Key: []byte("machine"), Value: []byte(strconv.Itoa(ts_id))},
		}
		mr := &metricRows[ts_id]
		mr.MetricNameRaw = mn.MarshalRaw(mr.MetricNameRaw[:0])
	}

	if flagdataset == "google" {
		readGoogle2019()
	}

	total_insert := int64(0)
	tNow := time.Now()
	switch flagdataset {
	case "zipf":
		total_insert = ingestVMZipfScrapes(s, metricRows, scrapeCountBatch)
	case "dynamic":
		total_insert = ingestVMDynamicScrapes(s, metricRows, scrapeCountBatch)
	case "google":
		total_insert = ingestVMGoogleScrapes(s, metricRows, scrapeCountBatch)
	default:
		fmt.Println("not supported dataset.")
	}
	since := time.Since(tNow)

	throughput := float64(total_insert) / float64(since.Seconds())
	t.Log(num_ts, since.Seconds(), throughput)
}

func TestWriteThroughPut(t *testing.T) {
	scrapeCountBatch := 2160000 // seconds, 12 hours
	num_ts := flagvar
	path := "BenchmarkCtxInsertThoughput"
	s := storage.MustOpenStorage(path, 0, 0, 0)
	defer func() {
		s.MustClose()
		if err := os.RemoveAll(path); err != nil {
			t.Fatalf("cannot remove storage at %q: %s", path, err)
		}
	}()

	vmsketch.Init()

	var mn storage.MetricName
	metricRows := make([]storage.MetricRow, num_ts)
	mn.MetricGroup = []byte("fake_metric")
	for ts_id := 0; ts_id < num_ts; ts_id++ {
		mn.Tags = []storage.Tag{
			{Key: []byte("machine"), Value: []byte(strconv.Itoa(ts_id))},
		}
		mr := &metricRows[ts_id]
		mr.MetricNameRaw = mn.MarshalRaw(mr.MetricNameRaw[:0])
		switch flagalgo {
		case "sampling":
			err := vmsketch.RegisterMetricNameFuncName(&mn, "avg_over_time", flag_sample_window*100, flag_sample_window)
			if err != nil {
				panic(fmt.Errorf("Failed register vmsketch cache Sampling instance %w", err))
			}
		case "ehkll":
			err := vmsketch.RegisterMetricNameFuncName(&mn, "quantile_over_time", flag_sample_window*100, flag_sample_window)
			if err != nil {
				panic(fmt.Errorf("Failed register vmsketch cache EHKLL instance %w", err))
			}
		case "ehuniv":
			err := vmsketch.RegisterMetricNameFuncName(&mn, "distinct_over_time", flag_sample_window*100, flag_sample_window)
			if err != nil {
				panic(fmt.Errorf("Failed register vmsketch cache EHuniv instance %w", err))
			}
		case "all":
			err := vmsketch.RegisterMetricNameFuncName(&mn, "avg_over_time", flag_sample_window*100, flag_sample_window)
			if err != nil {
				panic(fmt.Errorf("Failed register vmsketch cache Sampling instance %w", err))
			}
			err = vmsketch.RegisterMetricNameFuncName(&mn, "quantile_over_time", flag_sample_window*100, flag_sample_window)
			if err != nil {
				panic(fmt.Errorf("Failed register vmsketch cache EHKLL instance %w", err))
			}
			err = vmsketch.RegisterMetricNameFuncName(&mn, "distinct_over_time", flag_sample_window*100, flag_sample_window)
			if err != nil {
				panic(fmt.Errorf("Failed register vmsketch cache EHuniv instance %w", err))
			}
		default:
			fmt.Println("not supported algorithm.")
		}
	}

	if flagdataset == "google" {
		readGoogle2019()
	}

	total_insert := int64(0)
	tNow := time.Now()
	switch flagdataset {
	case "zipf":
		total_insert = ingestZipfScrapes(s, metricRows, scrapeCountBatch)
	case "dynamic":
		total_insert = ingestDynamicScrapes(s, metricRows, scrapeCountBatch)
	case "google":
		total_insert = ingestGoogleScrapes(s, metricRows, scrapeCountBatch)
	default:
		fmt.Println("not supported dataset.")
	}
	since := time.Since(tNow)

	throughput := float64(total_insert) / float64(since.Seconds())
	t.Log(num_ts, since.Seconds(), throughput)
}

func ingestVMZipfScrapes(st *storage.Storage, mrs []storage.MetricRow, scrapeTotCount int) int64 {
	scrapeBatch := 100
	const second = 100
	var count atomic.Int64
	count.Store(0)

	lbl_batch := len(mrs) / flagthreads
	if lbl_batch*flagthreads < len(mrs) {
		lbl_batch += 1
	}
	fmt.Println("Threads:", flagthreads, ";", "Each thread handles", lbl_batch, "timeseries.")

	for i := 0; i < scrapeTotCount; i += scrapeBatch {
		var wg sync.WaitGroup
		currTime := int64(i * second)
		lbls := mrs
		for len(lbls) > 0 {
			b := lbl_batch
			if len(lbls) < b {
				b = len(lbls)
			}
			batch := lbls[:b]
			lbls = lbls[b:]
			wg.Add(1)
			go func(currTime int64) {
				defer wg.Done()

				var s float64 = 1.01
				var v float64 = 1
				var RAND *rand.Rand = rand.New(rand.NewSource(time.Now().Unix()))
				z := rand.NewZipf(RAND, s, v, uint64(100000))

				for j := 0; j < scrapeBatch; j++ {
					rowsToInsert := make([]storage.MetricRow, 0, len(batch))
					ts := int64(j*second) + currTime
					for _, mr := range batch {
						mr.Value = float64(z.Uint64())
						mr.Timestamp = ts
						rowsToInsert = append(rowsToInsert, mr)
					}

					if err := st.AddRows(rowsToInsert, defaultPrecisionBits); err != nil {
						panic(fmt.Errorf("cannot add rows to storage: %w", err))
					}
					count.Add(int64(len(rowsToInsert)))
				}

			}(currTime)
		}
		wg.Wait()
	}

	return count.Load()
}

func ingestZipfScrapes(st *storage.Storage, mrs []storage.MetricRow, scrapeTotCount int) int64 {
	scrapeBatch := 100
	const second = 100
	var count atomic.Int64
	count.Store(0)

	lbl_batch := len(mrs) / flagthreads
	if lbl_batch*flagthreads < len(mrs) {
		lbl_batch += 1
	}
	fmt.Println("Threads:", flagthreads, ";", "Each thread handles", lbl_batch, "timeseries.")

	for i := 0; i < scrapeTotCount; i += scrapeBatch {
		var wg sync.WaitGroup
		currTime := int64(i * second)
		lbls := mrs
		for len(lbls) > 0 {
			b := lbl_batch
			if len(lbls) < b {
				b = len(lbls)
			}
			batch := lbls[:b]
			lbls = lbls[b:]
			wg.Add(1)
			go func(currTime int64) {
				defer wg.Done()

				var s float64 = 1.01
				var v float64 = 1
				var RAND *rand.Rand = rand.New(rand.NewSource(time.Now().Unix()))
				z := rand.NewZipf(RAND, s, v, uint64(100000))

				for j := 0; j < scrapeBatch; j++ {
					var wg_sketch sync.WaitGroup
					rowsToInsert := make([]storage.MetricRow, 0, len(batch))
					ts := int64(j*second) + currTime
					for _, mr := range batch {
						mr.Value = float64(z.Uint64())
						mr.Timestamp = ts
						rowsToInsert = append(rowsToInsert, mr)
					}

					wg_sketch.Add(1)
					go func(rowsToInsert []storage.MetricRow) {
						defer wg_sketch.Done()
						for _, mr := range rowsToInsert {
							vmsketch.AddRow(mr.MetricNameRaw, mr.Timestamp, mr.Value)
							count.Add(1)
						}
					}(rowsToInsert)
					if err := st.AddRows(rowsToInsert, defaultPrecisionBits); err != nil {
						panic(fmt.Errorf("cannot add rows to storage: %w", err))
					}
					wg_sketch.Wait()

				}

			}(currTime)
		}
		wg.Wait()
	}

	return count.Load()
}

var google_vec []float64

func readGoogle2019() {
	filename := "testdata/google2019.csv"
	vec := make([]float64, 0)

	f, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	reader := csv.NewReader(f)

	records, err := reader.ReadAll()
	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	for idx, record := range records {
		// fmt.Println(record, reflect.TypeOf(record))
		if idx == 0 {
			continue
		}
		F, _ := strconv.ParseFloat(strings.TrimSpace(record[0]), 64)
		vec = append(vec, F)
	}
	google_vec = vec
}

func ingestVMGoogleScrapes(st *storage.Storage, mrs []storage.MetricRow, scrapeTotCount int) int64 {
	scrapeBatch := 100
	const second = 100
	var count atomic.Int64
	count.Store(0)

	lbl_batch := len(mrs) / flagthreads
	if lbl_batch*flagthreads < len(mrs) {
		lbl_batch += 1
	}
	fmt.Println("Threads:", flagthreads, ";", "Each thread handles", lbl_batch, "timeseries.")

	for i := 0; i < scrapeTotCount; i += scrapeBatch {
		var wg sync.WaitGroup
		currTime := int64(i * second)
		lbls := mrs
		for len(lbls) > 0 {
			b := lbl_batch
			if len(lbls) < b {
				b = len(lbls)
			}
			batch := lbls[:b]
			lbls = lbls[b:]
			wg.Add(1)
			go func(currTime int64) {
				defer wg.Done()

				for j := 0; j < scrapeBatch; j++ {

					rowsToInsert := make([]storage.MetricRow, 0, len(batch))
					ts := int64(j*second) + currTime
					for _, mr := range batch {
						mr.Value = google_vec[i+j]
						mr.Timestamp = ts
						rowsToInsert = append(rowsToInsert, mr)
					}
					if err := st.AddRows(rowsToInsert, defaultPrecisionBits); err != nil {
						panic(fmt.Errorf("cannot add rows to storage: %w", err))
					}
					count.Add(int64(len(rowsToInsert)))
				}

			}(currTime)
		}
		wg.Wait()
	}

	return count.Load()
}

func ingestGoogleScrapes(st *storage.Storage, mrs []storage.MetricRow, scrapeTotCount int) int64 {
	scrapeBatch := 100
	const second = 100
	var count atomic.Int64
	count.Store(0)

	lbl_batch := len(mrs) / flagthreads
	if lbl_batch*flagthreads < len(mrs) {
		lbl_batch += 1
	}
	fmt.Println("Threads:", flagthreads, ";", "Each thread handles", lbl_batch, "timeseries.")

	for i := 0; i < scrapeTotCount; i += scrapeBatch {
		var wg sync.WaitGroup
		currTime := int64(i * second)
		lbls := mrs
		for len(lbls) > 0 {
			b := lbl_batch
			if len(lbls) < b {
				b = len(lbls)
			}
			batch := lbls[:b]
			lbls = lbls[b:]
			wg.Add(1)
			go func(currTime int64) {
				defer wg.Done()

				for j := 0; j < scrapeBatch; j++ {
					var wg_sketch sync.WaitGroup
					rowsToInsert := make([]storage.MetricRow, 0, len(batch))
					ts := int64(j*second) + currTime
					for _, mr := range batch {
						mr.Value = google_vec[i+j]
						mr.Timestamp = ts
						rowsToInsert = append(rowsToInsert, mr)
					}

					wg_sketch.Add(1)
					go func(rowsToInsert []storage.MetricRow) {
						defer wg_sketch.Done()
						for _, mr := range rowsToInsert {
							vmsketch.AddRow(mr.MetricNameRaw, mr.Timestamp, mr.Value)
							count.Add(1)
						}
					}(rowsToInsert)
					if err := st.AddRows(rowsToInsert, defaultPrecisionBits); err != nil {
						panic(fmt.Errorf("cannot add rows to storage: %w", err))
					}
					wg_sketch.Wait()

				}

			}(currTime)
		}
		wg.Wait()
	}

	return count.Load()
}

var (
	const_1M int = 10000
	const_2M int = 20000
	const_3M int = 30000
)

func ingestDynamicScrapes(st *storage.Storage, mrs []storage.MetricRow, scrapeTotCount int) int64 {
	scrapeBatch := 100
	const second = 100
	var count atomic.Int64
	count.Store(0)

	lbl_batch := len(mrs) / flagthreads
	if lbl_batch*flagthreads < len(mrs) {
		lbl_batch += 1
	}
	fmt.Println("Threads:", flagthreads, ";", "Each thread handles", lbl_batch, "timeseries.")

	start := time.Now()
	for i := 0; i < scrapeTotCount; i += scrapeBatch {
		var wg sync.WaitGroup
		currTime := int64(i * second)
		lbls := mrs
		for len(lbls) > 0 {
			b := lbl_batch
			if len(lbls) < b {
				b = len(lbls)
			}
			batch := lbls[:b]
			lbls = lbls[b:]
			wg.Add(1)
			go func(currTime int64) {
				defer wg.Done()

				var s float64 = 1.01
				var v float64 = 1
				var RAND *rand.Rand = rand.New(rand.NewSource(time.Now().Unix()))
				z := rand.NewZipf(RAND, s, v, uint64(100000))

				for j := 0; j < scrapeBatch; j++ {
					var wg_sketch sync.WaitGroup
					rowsToInsert := make([]storage.MetricRow, 0, len(batch))
					ts := int64(j*second) + currTime
					for _, mr := range batch {
						var value float64 = 0
						if j%const_3M < const_1M {
							value = float64(z.Uint64())
						} else if j%const_3M < const_2M {
							value = rand.Float64() * 100000
						} else {
							value = rand.NormFloat64()*50000 + 10000
						}

						mr.Value = value
						mr.Timestamp = ts
						rowsToInsert = append(rowsToInsert, mr)
					}

					wg_sketch.Add(1)
					go func(rowsToInsert []storage.MetricRow) {
						defer wg_sketch.Done()
						for _, mr := range rowsToInsert {
							vmsketch.AddRow(mr.MetricNameRaw, mr.Timestamp, mr.Value)
							count.Add(1)
						}
					}(rowsToInsert)
					if err := st.AddRows(rowsToInsert, defaultPrecisionBits); err != nil {
						panic(fmt.Errorf("cannot add rows to storage: %w", err))
					}
					wg_sketch.Wait()

				}

			}(currTime)
		}
		wg.Wait()
		elapsed := time.Since(start)
		fmt.Println("throughput:", i, float64(count.Load())/elapsed.Seconds())
	}

	return count.Load()
}

func ingestVMDynamicScrapes(st *storage.Storage, mrs []storage.MetricRow, scrapeTotCount int) int64 {
	scrapeBatch := 100
	const second = 100
	var count atomic.Int64
	count.Store(0)

	lbl_batch := len(mrs) / flagthreads
	if lbl_batch*flagthreads < len(mrs) {
		lbl_batch += 1
	}
	fmt.Println("Threads:", flagthreads, ";", "Each thread handles", lbl_batch, "timeseries.")

	for i := 0; i < scrapeTotCount; i += scrapeBatch {
		var wg sync.WaitGroup
		currTime := int64(i * second)
		lbls := mrs
		for len(lbls) > 0 {
			b := lbl_batch
			if len(lbls) < b {
				b = len(lbls)
			}
			batch := lbls[:b]
			lbls = lbls[b:]
			wg.Add(1)
			go func(currTime int64) {
				defer wg.Done()

				var s float64 = 1.01
				var v float64 = 1
				var RAND *rand.Rand = rand.New(rand.NewSource(time.Now().Unix()))
				z := rand.NewZipf(RAND, s, v, uint64(100000))

				for j := 0; j < scrapeBatch; j++ {
					rowsToInsert := make([]storage.MetricRow, 0, len(batch))
					ts := int64(j*second) + currTime
					for _, mr := range batch {
						var value float64 = 0
						if (i+j)%const_3M < const_1M {
							value = float64(z.Uint64())
						} else if (i+j)%const_3M < const_2M {
							value = rand.Float64() * 100000
						} else {
							value = rand.NormFloat64()*50000 + 10000
						}
						mr.Value = value
						mr.Timestamp = ts
						rowsToInsert = append(rowsToInsert, mr)
					}
					if err := st.AddRows(rowsToInsert, defaultPrecisionBits); err != nil {
						panic(fmt.Errorf("cannot add rows to storage: %w", err))
					}
					count.Add(int64(len(rowsToInsert)))
				}

			}(currTime)
		}
		wg.Wait()
	}

	return count.Load()
}
