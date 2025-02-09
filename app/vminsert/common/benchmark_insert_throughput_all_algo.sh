
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=google -algorithm=all -sample_window=10000 > 64_threads_insertion_throughput/google_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=google -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/google_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=google -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/google_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=google -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/google_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=google -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/google_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/

rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=google -algorithm=all -sample_window=100000 > 64_threads_insertion_throughput/google_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=google -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/google_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=google -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/google_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=google -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/google_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=google -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/google_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/

rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=google -algorithm=all -sample_window=1000000 > 64_threads_insertion_throughput/google_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=google -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/google_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=google -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/google_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=google -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/google_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=google -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/google_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/



rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=10000 > 64_threads_insertion_throughput/zipf_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/zipf_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/zipf_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/zipf_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/zipf_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/

rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=100000 > 64_threads_insertion_throughput/zipf_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/zipf_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/zipf_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/zipf_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/zipf_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/

rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=1000000 > 64_threads_insertion_throughput/zipf_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/zipf_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/zipf_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/zipf_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=zipf -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/zipf_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/




rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=10000 > 64_threads_insertion_throughput/dynamic_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/dynamic_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/dynamic_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/dynamic_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=10000 >> 64_threads_insertion_throughput/dynamic_all_10K.txt
rm -r BenchmarkCtxInsertThoughput/

rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=100000 > 64_threads_insertion_throughput/dynamic_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/dynamic_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/dynamic_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/dynamic_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=100000 >> 64_threads_insertion_throughput/dynamic_all_100K.txt
rm -r BenchmarkCtxInsertThoughput/

rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=1000000 > 64_threads_insertion_throughput/dynamic_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/dynamic_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/dynamic_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/dynamic_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
go test -v -count 2 -timeout 0 -run ^TestWriteThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000 -numthreads=64 -dataset=dynamic -algorithm=all -sample_window=1000000 >> 64_threads_insertion_throughput/dynamic_all_1M.txt
rm -r BenchmarkCtxInsertThoughput/
