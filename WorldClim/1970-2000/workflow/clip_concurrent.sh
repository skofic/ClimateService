#!/bin/sh

###
# Clip maps to EUFGIS region.
# Parallel processing version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/WorldClim/1970-2000"

echo "=================================================="
echo "= CLIP FILES"
echo "=================================================="
start=$(date +%s)

###
# Launch jobs in batch mode.
###
for code in "bio" "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
do
	
	###
	# Set command.
	###
	cmd="${epoc}/script_geo/ClipToForgeniusMask_${code}.sh"
	
	###
	# Launch script in batch.
	###
	$cmd | tee "${epoc}/log/1_PREPARE_CLIP_${code}.log" &
	
	###
	# Get job number.
	###
	pids+=($!)

done

###
# Wait for all jobs to finish and get status.
###
for pid in "${pids[@]}"
do
	
	###
	# Wait for current job to finish.
	###
	wait "${pid}"
	
	###
	# Get job status.
	###
	status+=($?)
	
done

echo "=================================================="

###
# Check all status codes and exit if any failed.
###
error=0
for i in "${!status[@]}"
do
	
	echo "Job $i status: ${status[$i]}"
	if [ ${status[$i]} -ne 0 ]
	then
		error=1
	fi
	
done

echo "=================================================="

if [ $error -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= CLIP FILES: $elapsed seconds"
echo "=================================================="
echo ""
