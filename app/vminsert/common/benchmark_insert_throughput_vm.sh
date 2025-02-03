
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=google > 64_threads_insertion_throughput/google_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=google  >> 64_threads_insertion_throughput/google_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=google  >> 64_threads_insertion_throughput/google_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=google  >> 64_threads_insertion_throughput/google_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=google  >> 64_threads_insertion_throughput/google_vm.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=zipf > 64_threads_insertion_throughput/zipf_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=zipf  >> 64_threads_insertion_throughput/zipf_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=zipf  >> 64_threads_insertion_throughput/zipf_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=zipf  >> 64_threads_insertion_throughput/zipf_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=zipf  >> 64_threads_insertion_throughput/zipf_vm.txt
rm -r BenchmarkCtxInsertThoughput/




rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=dynamic > 64_threads_insertion_throughput/dynamic_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_vm.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestVMWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_vm.txt
rm -r BenchmarkCtxInsertThoughput/


