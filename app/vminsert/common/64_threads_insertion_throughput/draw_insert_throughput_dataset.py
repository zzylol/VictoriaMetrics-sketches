import matplotlib.pyplot as plt
import numpy as np
import os.path


labels = {
    "prometheus": "Prometheus",
    "sampling_10K": "USampling_10K",
    "sampling_100K": "USampling_100K",
    "sampling_1M": "USampling_1M",
    "ehuniv_10K": "EHUniv_10K",
    "ehuniv_100K": "EHUniv_100K", 
    "ehuniv_1M": "EHUniv_1M",
    "ehkll_10K": "EHKLL_10K", 
    "ehkll_100K": "EHKLL_100K",
    "ehkll_1M": "EHKLL_1M",
    "all_10K": "All_10K",
    "all_100K": "All_100K",
    "all_1M": "All_1M",
    "vm": "VictoriaMetrics",
}

marker_list = { 
    "Prometheus": "*",
    "VictoriaMetrics": "*",
    "USampling_1M": "o", 
    "USampling_100K": "o",
    "USampling_10K": "o",
    "EHUniv_1M": "^",
    "EHUniv_100K": "^",
    "EHUniv_10K": "^",
    "EHKLL_10K": "s",
    "EHKLL_100K": "s",
    "EHKLL_1M": "s",
    "All_10K": "v",
    "All_100K": "v",
    "All_1M": "v"}


plt.rcParams['font.size'] = 30  # 48
plt.rcParams['axes.labelsize'] = 30  # 48
plt.rcParams['legend.fontsize'] = 27  # 55
plt.rcParams["figure.figsize"] = (8, 6)
plt.rcParams['pdf.fonttype'] = 42

num_ts = [1, 10, 100, 1000, 10000]  
datasets = ["dynamic"] # ["zipf", "dynamic", "google"]
systems = ["ehkll", "ehuniv", "sampling"] # , "all"]
window_sizes = ["10K", "100K", "1M"]


for data in datasets:
    print("dataset =", data)
    baselines = []
    for sys in systems:
        for win in window_sizes:
            baselines.append(sys + "_" + win)
    baselines.append("vm")

    print(baselines)

    write_throughput = {}
    plot_throughput = {}
    for sys in baselines:
        write_throughput[sys] = {}
        plot_throughput[sys] = []
        for ts in num_ts:
            write_throughput[sys][ts] = []


    for sys in baselines:
        filename = data + "_" + sys + ".txt"
        
        if os.path.isfile(filename):
            with open(filename, "r") as f:
                lines = f.readlines()
                for line in lines:
                    arr = line.strip("\n").split()
                    # print(arr)
                    if len(arr) == 4 and (arr[0].startswith("insert_throughput_test.go") or arr[0].startswith("db_test.go") or arr[0].startswith("promsketches_test.go")):
                        ts = int(arr[1])
                        throughput = float(arr[3])
                        if ts in write_throughput[sys]:
                            write_throughput[sys][ts].append(throughput)
                        
            for ts in num_ts:
                plot_throughput[sys].append(np.average(write_throughput[sys][ts]))
        else:
            print(data + "_" + filename, "not found")
            for ts in num_ts:
                plot_throughput[sys].append(0)

    print(write_throughput)

    fig = plt.figure()
    out_num_ts = [x for x in num_ts]
    for sys in baselines:
        plt.plot(out_num_ts, plot_throughput[sys], label=labels[sys], marker = marker_list[labels[sys]], linewidth=3, markersize=25, fillstyle="none", markeredgewidth=3)
    
    plt.ticklabel_format(axis='y', style='sci', scilimits=(6,6))
    plt.xscale('log')
    plt.yscale("log")
    # plt.ylim([130000, 200000000])
    plt.xlabel("Number of Timeseries")
    plt.ylabel("Throughput(Samples/s)")
    plt.grid()
    # plt.legend(loc='center left', bbox_to_anchor=(1, 0.5))
    # plt.legend(loc="upper center", bbox_to_anchor=(0.5, 1.5), ncol=3)
    plt.savefig("vm_sketch_insert_throughput_" + data + ".pdf", bbox_inches='tight')