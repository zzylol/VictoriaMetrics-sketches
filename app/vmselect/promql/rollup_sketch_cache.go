package promql

import (
	"github.com/VictoriaMetrics/VictoriaMetrics/lib/logger"
	"github.com/zzylol/promsketch"
)

var sketchCache *promsketch.VMSketches

// InitRollupSketchCache initializes the rollupResult cache
// ResetRollupSketchCache must be called when the cache must be reset.
// StopRollupSketchCache must be called when the cache isn't needed anymore.

func InitRollupSketchCache() {
	sketchCache = promsketch.NewVMSketches()
}

func StopRollupSketchCache() {
	sketchCAche.Stop()
}

func ResetRollupSketchCache() {
	rollupSketchCacheResets.Inc()
	sketchCache.Reset()
	logger.Infof("rollupSketch cache has been cleared")
}
