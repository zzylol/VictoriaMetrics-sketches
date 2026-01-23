package promsketch

import "sync/atomic"

// mergedBucketsTotal tracks the total number of sketch buckets merged across all queries.
// It is used for lightweight per-query accounting by sampling the counter before and after evaluation.
var mergedBucketsTotal atomic.Uint64

// addMergedBucketsTotal increments the global merged bucket counter.
func addMergedBucketsTotal(n int) {
	if n <= 0 {
		return
	}
	mergedBucketsTotal.Add(uint64(n))
}

// MergedBucketsTotal returns the global merged bucket counter.
func MergedBucketsTotal() uint64 {
	return mergedBucketsTotal.Load()
}
