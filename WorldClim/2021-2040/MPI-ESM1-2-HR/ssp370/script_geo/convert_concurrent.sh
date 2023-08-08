#!/bin/sh

###
# Convert maps to CSV.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Convert maps to CSV."
echo "====================================================================="

###
# Globals.
###
cmd="${path}/WorldClim/script_geo/convert.sh"
epoc="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
from="${epoc}/Clipped"
dest="${epoc}/CSV"

echo "=================================================="
echo "= CONVERT FILES"
echo "=================================================="
start=$(date +%s)

###
# Convert clipped maps to CSV format.
###
for var in "bio" "pr" "tasmax" "tasmin"
do
	
	echo "==> ${var}"
    
	###
	# Launch script in batch.
	###
	$cmd "${from}/${var}.tif" "${dest}/${var}.csv" | tee "${epoc}/log/1_PREPARE_CONVERT_${var}.log" &
	
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
echo "= CONVERT FILES: $elapsed seconds"
echo "=================================================="
echo ""
