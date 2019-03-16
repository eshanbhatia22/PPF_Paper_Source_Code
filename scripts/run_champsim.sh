## Usage: ./run_champsim.sh gshare-no-spp_dev-lru-1core 20 100
TRACE_DIR=/scratch/user/djimenez/champsim-traces/speccpu2017/xz
TRACE_FOLDER_LIST=(600.perlbench_s 602.gcc_s 603.bwaves_s 605.mcf_s 607.cactuBSSN_s 619.lbm_s 620.omnetpp_s 621.wrf_s 623.xalancbmk_s 625.x264_s 627.cam4_s 628.pop2_s 631.deepsjeng_s 638.imagick_s 641.leela_s 644.nab_s 648.exchange2_s 649.fotonik3d_s 654.roms_s 657.xz_s )
binary=${1}
n_warm=${2}
n_sim=${3}
option=${4}

echo "Running on all traces present in $TRACE_DIR/"
echo "Entering directory results_${n_sim}M"
echo ""

mkdir -p results_${n_sim}M

if [ -f mycommands ]; then
	rm mycommands 
fi

if [ -f mycommands_shuffled ]; then
	rm mycommands_shuffled 
fi

for s in ${TRACE_FOLDER_LIST[@]}
    do
    echo " Running on all traces present in $TRACE_DIR/$s/"
    TRACES=$TRACE_DIR/$s/*.champsimtrace.xz
    for t in $TRACES
    do
    	trace_1=`echo $t | cut -d '/' -f 9 | cut -d '.' -f 1` 
    	trace_2=`echo $t | cut -d '/' -f 9 | cut -d '.' -f 2` 
		trace=$trace_1.$trace_2

    	FILE=results_${n_sim}M/${trace}-${binary}${option}.txt
		if [ -f $FILE ]; then
    		echo "  File $FILE exists. Skipping."
    	else 
    		echo "  Running on $trace..."
    		echo "(./bin/${binary} -warmup_instructions ${n_warm}000000 -simulation_instructions ${n_sim}000000 ${option} -traces ${TRACE_DIR}/$s/${trace}.champsimtrace.xz) &> results_${n_sim}M/${trace}-${binary}${option}.txt" >> mycommands
    	fi
    	sleep 0.03
    done
	echo ""
done

echo "Shuffling commands"
shuf mycommands > mycommands_shuffled
