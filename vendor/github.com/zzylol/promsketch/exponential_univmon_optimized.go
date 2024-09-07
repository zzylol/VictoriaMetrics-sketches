package promsketch

import (
	"context"
	"errors"
	"fmt"
	"math/rand"
	"strconv"
	"sync"
	"sync/atomic"
	"time"

	"github.com/OneOfOne/xxhash"
	"github.com/RoaringBitmap/roaring/v2"
)

type EHArray struct {
	samples     []float64
	max_time    int64
	min_time    int64
	bucket_size int
}

func NewArray() *EHArray {
	return &EHArray{
		samples: make([]float64, 0),
	}
}

func (arr *EHArray) MergeWith(other *EHArray) {
	arr.samples = append(arr.samples, other.samples...)
}

type ExpoHistogramUnivOptimized struct {
	cs_seed1         []uint32
	cs_seed2         []uint32
	seed3            uint32
	s_count          int           // sketch count
	arr_count        int           // array count
	univs            []*UnivSketch // larger bucket is a univsketch
	array            []*EHArray    // smaller bucket is exact, storing all samples
	max_array_size   int
	min_array_size   int
	k                int64
	time_window_size int64
	univPool         UnivSketchPool
	putch            chan int64

	ctx    context.Context
	cancel func()     // Cancellation function for background ehuniv cleaning.
	mutex  sync.Mutex // when updating s_count and buckets, query should wait; when query, update() should wait
}

/*------------------------------------------------------------------------------
			Exponential Histogram for univmon
--------------------------------------------------------------------------------*/

func ExpoInitUnivOptimized(k int64, time_window_size int64) (ehu *ExpoHistogramUnivOptimized) {
	ehu = &ExpoHistogramUnivOptimized{
		k:                k,
		s_count:          0,
		arr_count:        0,
		max_array_size:   32768,
		min_array_size:   1,
		time_window_size: time_window_size,
		univs:            make([]*UnivSketch, 0),
		array:            make([]*EHArray, 0),
	}

	ehu.putch = make(chan int64, 100)

	ehu.cs_seed1 = make([]uint32, CS_ROW_NO_Univ_ELEPHANT)
	ehu.cs_seed2 = make([]uint32, CS_ROW_NO_Univ_ELEPHANT)
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < CS_ROW_NO_Univ_ELEPHANT; i++ {
		ehu.cs_seed1[i] = rand.Uint32()
		ehu.cs_seed2[i] = rand.Uint32()
	}
	ehu.seed3 = rand.Uint32()

	ehu.univPool = UnivSketchPool{pool: make([]*UnivSketch, UnivPoolCAP), size: 0, max_size: UnivPoolCAP}
	for i := uint32(0); i < UnivPoolCAP; i++ {
		ehu.univPool.pool[i], _ = NewUnivSketchPyramid(TOPK_SIZE, CS_ROW_NO_Univ_ELEPHANT, CS_COL_NO_Univ_ELEPHANT, CS_LVLS, ehu.cs_seed1, ehu.cs_seed2, ehu.seed3, int64(i))
	}
	ehu.univPool.bm = roaring.New()

	ehu.ctx, ehu.cancel = context.WithCancel(context.Background())
	ehu.StartBackgroundClean(ehu.ctx)
	ehu.StartBackgroundClean(ehu.ctx)

	return ehu
}

func (ehu *ExpoHistogramUnivOptimized) UpdateWindow(window int64) {
	ehu.mutex.Lock()
	ehu.time_window_size = window
	fmt.Println("cur window=", ehu.time_window_size)
	ehu.mutex.Unlock()
}

func (ehu *ExpoHistogramUnivOptimized) StartBackgroundClean(ctx context.Context) {
	go func(ctx context.Context) {
		for {
			select {
			case <-ctx.Done():
				return
			default:
			}
			pool_idx, more := <-ehu.putch
			if more {
				ehu.putUnivSketch(pool_idx)
			} else {
				return
			}
		}
	}(ctx)
}

func (ehu *ExpoHistogramUnivOptimized) StopBackgroundClean() {
	close(ehu.putch)
	ehu.cancel()
}

func (ehu *ExpoHistogramUnivOptimized) putUnivSketch(pool_idx int64) {
	ehu.univPool.mutex.Lock()
	ehu.univPool.pool[pool_idx].Free()
	ehu.univPool.bm.Remove(uint32(pool_idx))
	atomic.AddUint32(&ehu.univPool.size, ^uint32(0))
	atomic.AddUint32(&ehu.univPool.toclean, ^uint32(0))
	ehu.univPool.mutex.Unlock()
}

func (ehu *ExpoHistogramUnivOptimized) GetUnivSketch() (*UnivSketch, error) {
	ehu.univPool.mutex.Lock()
	if ehu.univPool.size == ehu.univPool.max_size {
		tmp, err := NewUnivSketchPyramid(TOPK_SIZE, CS_ROW_NO_Univ_ELEPHANT, CS_COL_NO_Univ_ELEPHANT, CS_LVLS, ehu.cs_seed1, ehu.cs_seed2, ehu.seed3, int64(ehu.univPool.max_size)) // New && init UnivMon
		if err != nil {
			return nil, errors.New("univ sketch allocation failed")
		}

		ehu.univPool.pool = append(ehu.univPool.pool, tmp)
		ehu.univPool.bm.Add(ehu.univPool.max_size)
		atomic.AddUint32(&ehu.univPool.max_size, 1)
		atomic.AddUint32(&ehu.univPool.size, 1)
		ehu.univPool.mutex.Unlock()
		return tmp, nil
	}

	iter := ehu.univPool.bm.Iterator()

	idx := uint32(0)
	last := uint32(0)
	last = last - 1
	flag := false
	if ehu.univPool.bm.Contains(0) == false {
		flag = true
	} else {
		for iter.HasNext() {
			item := iter.Next()
			if item > 0 && last != item-1 {
				idx = item - 1
				flag = true
				break
			}
			last = item
		}

		if !flag {
			idx = last + 1
		}
	}

	// fmt.Println(idx)

	univ := ehu.univPool.pool[idx]
	ehu.univPool.bm.Add(idx)
	atomic.AddUint32(&ehu.univPool.size, 1)
	ehu.univPool.mutex.Unlock()
	return univ, nil
}

func (ehu *ExpoHistogramUnivOptimized) PutUnivSketch(u *UnivSketch) error {
	if u.pool_idx == -1 {
		return nil
	}
	// t_now := time.Now()
	// fmt.Println("put ", u.pool_idx)
	atomic.AddUint32(&ehu.univPool.toclean, 1)
	for {
		if len(ehu.putch) == cap(ehu.putch) {
			// channel is full
			continue
		} else {
			ehu.putch <- u.pool_idx
			break
		}
	}
	// since := time.Since(t_now)
	// fmt.Println("put time=", since)
	return nil
}

func (ehu *ExpoHistogramUnivOptimized) Update(time_ int64, fvalue float64) {

	ehu.mutex.Lock()
	removed := 0
	for i := 0; i < ehu.s_count; i++ {
		if ehu.univs[i].max_time < time_-ehu.time_window_size {
			removed++
		} else {
			break
		}
	}

	if removed > 0 {
		ehu.s_count = ehu.s_count - removed
		for i := 0; i < removed; i++ {
			ehu.PutUnivSketch(ehu.univs[i])
		}
		ehu.univs = ehu.univs[removed:]
	}

	removed = 0
	for i := 0; i < ehu.arr_count; i++ {
		if ehu.array[i].max_time < time_-ehu.time_window_size {
			removed++
		} else {
			break
		}
	}

	if removed > 0 {
		ehu.arr_count = ehu.arr_count - removed
		ehu.array = ehu.array[removed:]
	}

	// add value to new EH bucket (array)
	if ehu.arr_count > 0 && ehu.array[ehu.arr_count-1].bucket_size < ehu.min_array_size {
		ehu.array[ehu.arr_count-1].samples = append(ehu.array[ehu.arr_count-1].samples, fvalue)
		ehu.array[ehu.arr_count-1].max_time = time_
		ehu.array[ehu.arr_count-1].bucket_size += 1
	} else {
		tmp_arr := NewArray()
		tmp_arr.samples = append(tmp_arr.samples, fvalue)
		tmp_arr.max_time, tmp_arr.min_time = time_, time_
		tmp_arr.bucket_size = 1
		ehu.array = append(ehu.array, tmp_arr)
		ehu.arr_count++
	}

	// Merge EH buckets (array)
	same_size_bucket := 1
	for i := ehu.arr_count - 2; i >= 0; i-- {
		if ehu.array[i].bucket_size == ehu.array[i+1].bucket_size {
			same_size_bucket += 1
		} else {
			if float64(same_size_bucket) >= float64(ehu.k)/2.0+2 {
				ehu.array[i+1].MergeWith(ehu.array[i+2])
				ehu.array[i+1].bucket_size += ehu.array[i+2].bucket_size
				ehu.array[i+1].max_time = MaxInt64(ehu.array[i+1].max_time, ehu.array[i+2].max_time)
				ehu.array[i+1].min_time = MinInt64(ehu.array[i+1].min_time, ehu.array[i+2].min_time)
				ehu.array = append(ehu.array[:i+2], ehu.array[i+3:]...)
				ehu.arr_count -= 1
			}
			same_size_bucket = 1
			if ehu.array[i+1].bucket_size == ehu.array[i].bucket_size {
				same_size_bucket += 1
			}
		}
	}

	if float64(same_size_bucket) >= float64(ehu.k)/2.0+2 {
		ehu.array[0].MergeWith(ehu.array[1])
		ehu.array[0].bucket_size += ehu.array[1].bucket_size
		ehu.array[0].max_time = MaxInt64(ehu.array[0].max_time, ehu.array[1].max_time)
		ehu.array[0].min_time = MinInt64(ehu.array[0].min_time, ehu.array[1].min_time)
		ehu.array = append(ehu.array[:1], ehu.array[2:]...)
		ehu.arr_count -= 1
	}

	if ehu.array[0].bucket_size >= ehu.max_array_size {
		// only under this, we may need to merge univmons

		// change oldest array into univmon
		tmp, err := ehu.GetUnivSketch()
		if err != nil {
			fmt.Println("[Expo Univ] memory full, cannot allocate UnivSketch")
			return
		}

		tmp.max_time, tmp.min_time = ehu.array[0].max_time, ehu.array[0].min_time
		ehu.univs = append(ehu.univs, tmp)

		for i := 0; i < len(ehu.array[0].samples); i++ {
			value := strconv.FormatFloat(ehu.array[0].samples[i], 'f', -1, 64)
			hash := xxhash.ChecksumString64S(value, uint64(tmp.seed))
			bottom_layer_num := findBottomLayerNum(hash, CS_LVLS)
			pos, sign := ehu.univs[0].cs_layers[0].position_and_sign([]byte(value))
			ehu.univs[ehu.s_count].univmon_processing_optimized(value, 1, bottom_layer_num, &pos, &sign)
		}
		ehu.s_count++

		ehu.array = ehu.array[1:]
		ehu.arr_count -= 1

		// Merge EH buckets (univmon)
		same_size_bucket = 1
		for i := ehu.s_count - 2; i >= 0; i-- {
			if ehu.univs[i].bucket_size == ehu.univs[i+1].bucket_size {
				same_size_bucket += 1
			} else {
				if float64(same_size_bucket) >= float64(ehu.k)/2.0+2 {

					ehu.univs[i+1].MergeWith(ehu.univs[i+2])

					ehu.univs[i+1].bucket_size += ehu.univs[i+2].bucket_size
					ehu.univs[i+1].max_time = MaxInt64(ehu.univs[i+1].max_time, ehu.univs[i+2].max_time)
					ehu.univs[i+1].min_time = MinInt64(ehu.univs[i+1].min_time, ehu.univs[i+2].min_time)
					ehu.PutUnivSketch(ehu.univs[i+2])
					ehu.univs = append(ehu.univs[:i+2], ehu.univs[i+3:]...)
					ehu.s_count -= 1

				}
				same_size_bucket = 1
				if ehu.univs[i+1].bucket_size == ehu.univs[i].bucket_size {
					same_size_bucket += 1
				}
			}
		}

		if float64(same_size_bucket) >= float64(ehu.k)/2.0+2 {
			ehu.univs[0].MergeWith(ehu.univs[1])
			ehu.univs[0].bucket_size += ehu.univs[1].bucket_size
			ehu.univs[0].max_time = MaxInt64(ehu.univs[0].max_time, ehu.univs[1].max_time)
			ehu.univs[0].min_time = MinInt64(ehu.univs[0].min_time, ehu.univs[1].min_time)
			ehu.PutUnivSketch(ehu.univs[1])
			ehu.univs = append(ehu.univs[:1], ehu.univs[2:]...)
			ehu.s_count -= 1
		}
	}

	ehu.mutex.Unlock()

}

func (eh *ExpoHistogramUnivOptimized) Cover(mint, maxt int64) bool {
	eh.mutex.Lock()
	if eh.s_count+eh.arr_count == 0 {
		eh.mutex.Unlock()
		return false
	}
	maxt_covered := (eh.array[0].min_time <= maxt)
	if eh.s_count > 0 {
		maxt_covered = maxt_covered || (eh.univs[0].min_time <= maxt)
	}
	isCovered := (eh.array[eh.arr_count-1].max_time-eh.time_window_size <= mint) && maxt_covered
	eh.mutex.Unlock()
	return isCovered
}

func (eh *ExpoHistogramUnivOptimized) GetMaxTime() int64 {
	if eh.s_count+eh.arr_count == 0 {
		return -1
	}
	return eh.array[eh.arr_count-1].max_time
}

func (ehu *ExpoHistogramUnivOptimized) print_buckets() {
	fmt.Println("k =", ehu.k)
	fmt.Println("s_count =", ehu.s_count)
	for i := 0; i < ehu.s_count; i++ {
		fmt.Println(i, ehu.univs[i].min_time, ehu.univs[i].max_time, ehu.univs[i].bucket_size)
	}
	fmt.Println("arr_count =", ehu.arr_count)
	for i := 0; i < ehu.arr_count; i++ {
		fmt.Println(i, ehu.array[i].min_time, ehu.array[i].max_time, ehu.array[i].bucket_size)
	}
}

func (eh *ExpoHistogramUnivOptimized) GetMemoryKB() float64 {
	var total_mem float64 = 0
	for i := 0; i < eh.s_count; i++ {
		total_mem += eh.univs[i].GetMemoryKBPyramid()
	}
	for i := 0; i < eh.arr_count; i++ {
		total_mem += float64(len(eh.array[i].samples)*8) / 1024
	}
	return total_mem
}

func (ehu *ExpoHistogramUnivOptimized) QueryIntervalMergeUniv(t1, t2 int64, cur_t int64) (univ *UnivSketch, arr *[]float64, err error) {
	var from_bucket, to_bucket int = 0, 0
	ehu.mutex.Lock()

	// ehu.print_buckets()
	// fmt.Println(" ")

	for i := 0; i < ehu.s_count; i++ {
		if t1 >= ehu.univs[i].min_time && t1 <= ehu.univs[i].max_time {
			from_bucket = i
		}
		if t2 >= ehu.univs[i].min_time && t2 <= ehu.univs[i].max_time {
			to_bucket = i
		}
	}

	for i := 0; i < ehu.arr_count; i++ {
		if t1 >= ehu.array[i].min_time && t1 <= ehu.array[i].max_time {
			from_bucket = i + ehu.s_count
		}
		if t2 >= ehu.array[i].min_time && t2 <= ehu.array[i].max_time {
			to_bucket = i + ehu.s_count
		}
	}

	if t2 > ehu.array[ehu.arr_count-1].max_time {
		to_bucket = ehu.arr_count - 1 + ehu.s_count
	}
	if ehu.s_count > 0 && t1 < ehu.univs[0].min_time {
		from_bucket = 0
	}

	if from_bucket < ehu.s_count {
		if AbsInt64(t1-ehu.univs[from_bucket].min_time) > AbsInt64(t1-ehu.univs[from_bucket].max_time) {
			from_bucket += 1
		}
	} else {
		if AbsInt64(t1-ehu.array[from_bucket-ehu.s_count].min_time) > AbsInt64(t1-ehu.array[from_bucket-ehu.s_count].max_time) {
			from_bucket += 1
		}
	}

	// fmt.Println("s_count =", ehu.s_count, "arr_count =", ehu.arr_count, "total =", ehu.s_count+ehu.arr_count)
	// fmt.Println("from_bucket =", from_bucket)
	// fmt.Println("to_bucket =", to_bucket)

	if to_bucket < ehu.s_count {
		// only in sketch part
		if from_bucket < to_bucket {
			merged_univ, _ := NewUnivSketchPyramid(TOPK_SIZE, CS_ROW_NO_Univ_ELEPHANT, CS_COL_NO_Univ_ELEPHANT, CS_LVLS, ehu.cs_seed1, ehu.cs_seed2, ehu.seed3, -1)
			for i := from_bucket; i <= to_bucket; i++ {
				merged_univ.MergeWith(ehu.univs[i])
				merged_univ.bucket_size += ehu.univs[i].bucket_size
			}
			ehu.mutex.Unlock()
			return merged_univ, nil, nil
		} else {
			ehu.mutex.Unlock()
			return ehu.univs[from_bucket], nil, nil
		}
	} else if from_bucket >= ehu.s_count {
		// only in array part
		samples := make([]float64, 0)
		for i := from_bucket - ehu.s_count; i <= to_bucket-ehu.s_count; i++ {
			samples = append(samples, ehu.array[i].samples...)
		}
		ehu.mutex.Unlock()
		return nil, &samples, nil
	} else {
		// merge univ and array
		merged_univ, _ := NewUnivSketchPyramid(TOPK_SIZE, CS_ROW_NO_Univ_ELEPHANT, CS_COL_NO_Univ_ELEPHANT, CS_LVLS, ehu.cs_seed1, ehu.cs_seed2, ehu.seed3, -1)
		for i := from_bucket; i < ehu.s_count; i++ {
			merged_univ.MergeWith(ehu.univs[i])
			merged_univ.bucket_size += ehu.univs[i].bucket_size
		}

		tmp := make(map[float64]int64)
		for i := 0; i < to_bucket-ehu.s_count; i++ {
			for j := 0; j < len(ehu.array[i].samples); j++ {
				if _, ok := tmp[ehu.array[i].samples[j]]; !ok {
					tmp[ehu.array[i].samples[j]] = 1
				} else {
					tmp[ehu.array[i].samples[j]] += 1
				}
			}
		}

		for k, v := range tmp {
			value := strconv.FormatFloat(k, 'f', -1, 64)
			hash := xxhash.ChecksumString64S(value, uint64(merged_univ.seed))
			bottom_layer_num := findBottomLayerNum(hash, CS_LVLS)
			pos, sign := ehu.univs[0].cs_layers[0].position_and_sign([]byte(value))
			merged_univ.univmon_processing_optimized(value, v, bottom_layer_num, &pos, &sign) // TODO: change to a map and group by key to univmon_update
		}
		ehu.mutex.Unlock()
		return merged_univ, nil, nil
	}
}
