package promsketch

import (
	"context"
	"math"
	"strconv"

	"github.com/OneOfOne/xxhash"
	"github.com/zzylol/go-kll"
)

// EvalWithExtraValues evaluates funcName over [t1..t2] similarly to (*SketchInstances).Eval(),
// but also merges the given extraValues into the computed result.
//
// extraValues must contain raw sample values belonging to (sketchMaxTime..t2] for the same series.
// The function never mutates the underlying SketchInstances; it only mutates local merged copies.
func EvalWithExtraValues(ctx context.Context, sketchIns *SketchInstances, funcName string, args []float64, t1, t2, t int64, extraValues []float64) float64 {
	_ = ctx
	if sketchIns == nil {
		return math.NaN()
	}
	if len(extraValues) == 0 {
		return sketchIns.Eval(nil, funcName, args, t1, t2, t)
	}
	if _, ok := VMFunctionCalls[funcName]; !ok {
		return math.NaN()
	}

	switch funcName {
	case "change_over_time", "count_over_time", "sum_over_time", "sum2_over_time", "avg_over_time", "stddev_over_time", "stdvar_over_time":
		if sketchIns.sampling == nil {
			return math.NaN()
		}
		baseCount := float64(sketchIns.sampling.QueryCount(t1, t2))
		baseSum := sketchIns.sampling.QuerySum(t1, t2)
		baseSum2 := sketchIns.sampling.QuerySum2(t1, t2)

		var tailCount float64
		var tailSum float64
		var tailSum2 float64
		for _, v := range extraValues {
			if math.IsNaN(v) || math.IsInf(v, 0) {
				continue
			}
			tailCount++
			tailSum += v
			tailSum2 += v * v
		}
		totalCount := baseCount + tailCount
		totalSum := baseSum + tailSum
		totalSum2 := baseSum2 + tailSum2

		switch funcName {
		case "change_over_time", "count_over_time":
			return totalCount
		case "sum_over_time":
			return totalSum
		case "sum2_over_time":
			return totalSum2
		case "avg_over_time":
			if totalCount <= 0 {
				return math.NaN()
			}
			return totalSum / totalCount
		case "stddev_over_time", "stdvar_over_time":
			if totalCount <= 0 {
				return math.NaN()
			}
			avg := totalSum / totalCount
			variance := totalSum2/totalCount - avg*avg
			if variance < 0 {
				variance = 0
			}
			if funcName == "stdvar_over_time" {
				return variance
			}
			return math.Sqrt(variance)
		default:
			return math.NaN()
		}

	case "quantile_over_time", "min_over_time", "max_over_time":
		if sketchIns.ehkll == nil {
			return math.NaN()
		}
		base := sketchIns.ehkll.QueryIntervalMergeKLL(t1, t2)
		if base == nil {
			return math.NaN()
		}
		merged := kll.New(sketchIns.ehkll.kll_k)
		merged.Merge(base)
		for _, v := range extraValues {
			if math.IsNaN(v) || math.IsInf(v, 0) {
				continue
			}
			merged.Update(v)
		}
		cdf := merged.CDF()
		switch funcName {
		case "quantile_over_time":
			if len(args) < 1 {
				return math.NaN()
			}
			return cdf.Query(args[0])
		case "min_over_time":
			return cdf.Query(0)
		case "max_over_time":
			return cdf.Query(1)
		default:
			return math.NaN()
		}

	case "entropy_over_time", "distinct_over_time", "l1_over_time", "l2_over_time":
		if sketchIns.ehuniv == nil {
			return math.NaN()
		}
		univ, m, n, err := sketchIns.ehuniv.QueryIntervalMergeUniv(t1, t2, t)
		if err != nil || (univ == nil && m == nil) {
			return math.NaN()
		}

		if m != nil {
			mm := *m
			for _, v := range extraValues {
				if math.IsNaN(v) || math.IsInf(v, 0) {
					continue
				}
				mm[v]++
				n++
			}
			switch funcName {
			case "entropy_over_time":
				if n <= 0 {
					return math.NaN()
				}
				return calc_entropy_map(&mm, n)
			case "distinct_over_time":
				return calc_distinct_map(&mm)
			case "l1_over_time":
				return calc_l1_map(&mm)
			case "l2_over_time":
				return calc_l2_map(&mm)
			default:
				return math.NaN()
			}
		}

		merged, _ := NewUnivSketchPyramid(TOPK_SIZE, CS_ROW_NO_Univ_ELEPHANT, CS_COL_NO_Univ_ELEPHANT, CS_LVLS, sketchIns.ehuniv.cs_seed1, sketchIns.ehuniv.cs_seed2, sketchIns.ehuniv.seed3, -1)
		merged.MergeWith(univ)
		merged.bucket_size = univ.bucket_size
		for _, v := range extraValues {
			if math.IsNaN(v) || math.IsInf(v, 0) {
				continue
			}
			valueStr := strconv.FormatFloat(v, 'f', -1, 64)
			hash := xxhash.ChecksumString64S(valueStr, uint64(merged.seed))
			bottomLayerNum := findBottomLayerNum(hash, CS_LVLS)
			pos, sign := merged.cs_layers[0].position_and_sign([]byte(valueStr))
			merged.univmon_processing_optimized(valueStr, 1, bottomLayerNum, &pos, &sign)
			merged.bucket_size++
		}
		switch funcName {
		case "entropy_over_time":
			if merged.bucket_size <= 0 {
				return math.NaN()
			}
			return merged.calcEntropy()
		case "distinct_over_time":
			return merged.calcCard()
		case "l1_over_time":
			return merged.calcL1()
		case "l2_over_time":
			return merged.calcL2()
		default:
			return math.NaN()
		}

	default:
		return math.NaN()
	}
}

