go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=1000
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=10000
go test -v -count 5 -timeout 0 -run ^TestWriteZipfThroughPut$ github.com/zzylol/VictoriaMetrics-sketches/app/vminsert/common -numts=100000


