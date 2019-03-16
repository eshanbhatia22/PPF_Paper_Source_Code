TRACE_DIR=/your/trace/directory/
binary=${1}
n_warm=${2}
n_sim=${3}
num=${4}
option=${5}

trace1=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $1}'`
trace2=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $2}'`
trace3=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $3}'`
trace4=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $4}'`
trace5=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $5}'`
trace6=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $6}'`
trace7=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $7}'`
trace8=`sed -n ''$num'p' sim_list/8core_workloads.txt | awk '{print $8}'`

mkdir -p results_8core
(./bin/${binary} -warmup_instructions ${n_warm}000000 -simulation_instructions ${n_sim}000000 ${option} -traces ${TRACE_DIR}/${trace1}.trace.gz ${TRACE_DIR}/${trace2}.trace.gz ${TRACE_DIR}/${trace3}.trace.gz ${TRACE_DIR}/${trace4}.trace.gz ${TRACE_DIR}/${trace5}.trace.gz ${TRACE_DIR}/${trace6}.trace.gz ${TRACE_DIR}/${trace7}.trace.gz ${TRACE_DIR}/${trace8}.trace.gz) &> results_8core/mix${num}-${binary}${option}.txt
