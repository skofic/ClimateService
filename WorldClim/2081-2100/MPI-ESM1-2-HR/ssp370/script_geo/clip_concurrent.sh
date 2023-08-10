#!/bin/sh

###
# Download period files.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip maps to region."
echo "====================================================================="

###
# Globals.
###
epoc="${path}/WorldClim/2081-2100/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
full="${epoc}/Full"
clip="${epoc}/Clipped"

echo "=================================================="
echo "= CLIP FILES"
echo "=================================================="
start=$(date +%s)

###
# Clip Float32 maps.
###
cmd="${path}/WorldClim/script_geo/clip_float32.sh"
for var in "bio" "tasmax" "tasmin"
do
	
	echo "==> Clip Float32 ${var}"
    
	###
	# Launch script in batch.
	###
	$cmd "${full}/${var}.tif" "${clip}/${var}.tif" "$poly" "$pnam" | tee "${epoc}/log/1_PREPARE_CLIP_${var}.log" &
	
	###
	# Get job number.
	###
	pids+=($!)

done

###
# Clip Int16 maps.
###
cmd="${path}/WorldClim/script_geo/clip_int16.sh"
for var in "pr"
do
	
	echo "==> Clip Int16 ${var}"
    
	###
	# Launch script in batch.
	###
	$cmd "${full}/${var}.tif" "${clip}/${var}.tif" "$poly" "$pnam" | tee "${epoc}/log/1_PREPARE_CLIP_${var}.log" &
	
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
