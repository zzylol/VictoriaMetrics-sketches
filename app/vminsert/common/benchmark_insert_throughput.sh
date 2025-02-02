rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=zipf > 64_threads_insertion_throughput/zipf_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=zipf > 64_threads_insertion_throughput/zipf_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=zipf > 64_threads_insertion_throughput/zipf_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=zipf  >> 64_threads_insertion_throughput/zipf_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=zipf > 64_threads_insertion_throughput/zipf_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=zipf > 64_threads_insertion_throughput/zipf_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/




rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=zipf > 64_threads_insertion_throughput/zipf_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/





rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=zipf > 64_threads_insertion_throughput/zipf_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=zipf > 64_threads_insertion_throughput/zipf_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=zipf > 64_threads_insertion_throughput/zipf_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=zipf  >> 64_threads_insertion_throughput/zipf_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/






rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=dynamic > 64_threads_insertion_throughput/dynamic_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=dynamic > 64_threads_insertion_throughput/dynamic_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/



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
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=dynamic > 64_threads_insertion_throughput/dynamic_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/




rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=dynamic > 64_threads_insertion_throughput/dynamic_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/





rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=dynamic > 64_threads_insertion_throughput/dynamic_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=dynamic > 64_threads_insertion_throughput/dynamic_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=dynamic  >> 64_threads_insertion_throughput/dynamic_ehuniv_100K.txt
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
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=google > 64_threads_insertion_throughput/google_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_10K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=google > 64_threads_insertion_throughput/google_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_100K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=google > 64_threads_insertion_throughput/google_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=sampling -dataset=google  >> 64_threads_insertion_throughput/google_sampling_1M.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=google > 64_threads_insertion_throughput/google_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_1M.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=google > 64_threads_insertion_throughput/google_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_100K.txt
rm -r BenchmarkCtxInsertThoughput/




rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=google > 64_threads_insertion_throughput/google_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=ehkll -dataset=google  >> 64_threads_insertion_throughput/google_ehkll_10K.txt
rm -r BenchmarkCtxInsertThoughput/





rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=google > 64_threads_insertion_throughput/google_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=10000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_10K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=google > 64_threads_insertion_throughput/google_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=100000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_100K.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=google > 64_threads_insertion_throughput/google_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -sample_window=1000000 -algorithm=ehuniv -dataset=google  >> 64_threads_insertion_throughput/google_ehuniv_1M.txt
rm -r BenchmarkCtxInsertThoughput/

