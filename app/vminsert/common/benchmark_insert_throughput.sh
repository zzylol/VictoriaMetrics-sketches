rm -r BenchmarkCtxInsertThoughput/
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100000
rm -r BenchmarkCtxInsertThoughput/
