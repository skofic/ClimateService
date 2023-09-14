#!/bin/sh

###
# Convert TIF maps to CSV format.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= PREPARE FILES"
echo "=================================================="
start=$(date +%s)

###
# Launch jobs in batch mode.
###
for folder in "FAPAN" "FAPAR" "HCWI" "CDI" "SMA" "SMI" "TWS"
do
	
	###
	# Parameters.
	###
	epoc="${path}/GlobalDroughtObservatory/${folder}"

	###
	# Launch script in batch.
	###
	cmd="${epoc}/workflow/1_prepare.sh"
	$cmd &
	
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
echo "= PREPARE FILES: $elapsed seconds"
echo "=================================================="
echo ""
