#!/bin/sh

###
# Download period files.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
peri="2081_2100"
cmd="${path}/WorldClim/script_geo/download.sh"
epoc="${path}/WorldClim/2081-2100/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
dest="${epoc}/Full"
dict="${path}/WorldClim/config/path_${peri}.txt"

echo "=================================================="
echo "= DOWNLOAD FILES"
echo "=================================================="
start=$(date +%s)

###
# Iterate list of files.
###
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    url=$(echo $line | cut -d ' ' -f 1)
    name=$(echo $line | cut -d ' ' -f 2)
    
	###
	# Launch script in batch.
	###
	$cmd "${url}" "${dest}/${name}" | tee "${epoc}/log/1_PREPARE_DOWNLOAD_${name}.log" &
	
	###
	# Get job number.
	###
	pids+=($!)
   
done < "$dict"

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
echo "= DOWNLOAD FILES: $elapsed seconds"
echo "=================================================="
echo ""
