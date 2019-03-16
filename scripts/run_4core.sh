##Usage: ./run_4core.sh gshare-no-spp_dev-lru-4core 20 100
TRACE_DIR=/scratch/user/djimenez/champsim-traces/speccpu2017/xz
binary=${1}
n_warm=${2}
n_sim=${3}
option=${4}

if [ -f ../mycommands_4core ]; then
	rm ../mycommands_4core
fi

for i in `seq 1 20`;
do
	trace1=`sed -n ''$i'p' ../sim_list/SPEC_2017_4core_mixes.list | awk '{print $1}'`
	trace2=`sed -n ''$i'p' ../sim_list/SPEC_2017_4core_mixes.list | awk '{print $2}'`
	trace3=`sed -n ''$i'p' ../sim_list/SPEC_2017_4core_mixes.list | awk '{print $3}'`
	trace4=`sed -n ''$i'p' ../sim_list/SPEC_2017_4core_mixes.list | awk '{print $4}'`

	echo "(./bin/${binary} -warmup_instructions ${n_warm}000000 -simulation_instructions ${n_sim}000000 ${option} -traces ${TRACE_DIR}/${trace1}.champsimtrace.xz ${TRACE_DIR}/${trace2}.champsimtrace.xz ${TRACE_DIR}/${trace3}.champsimtrace.xz ${TRACE_DIR}/${trace4}.champsimtrace.xz) &> results_4core_${n_sim}M/$i-${binary}${option}.txt" >> ../mycommands_4core
done
