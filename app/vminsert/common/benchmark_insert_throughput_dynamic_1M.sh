rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=dynamic > 64_threads_insertion_throughput/dynamic_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=dynamic > 64_threads_insertion_throughput/dynamic_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/

 
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=dynamic > 64_threads_insertion_throughput/dynamic_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_1M.txt
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


