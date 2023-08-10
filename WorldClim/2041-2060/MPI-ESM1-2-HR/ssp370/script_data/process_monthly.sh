#!/bin/sh

###
# Process multi-band monthly variables.
#
# The script will process all bioclimatic CSV files by:
# - loading the data into the database,
# - mapping variable names to descriptor names
# - and dump a JSONL file with the final period data format.
#
# This is the first step in the PROCESS workflow.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Process monthly data."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
epoc="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"
cmd="${path}/WorldClim/script_data/process_multi_monthly.sh"

echo "--------------------------------------------------"
start=$(date +%s)

for name in "pr" "tasmax" "tasmin"
do

	###
	# Parameters.
	###
	file="${epoc}/CSV/${name}.csv.gz"
	expo="${epoc}/data/${name}.jsonl.gz"

	###
	# Process converted CSV data.
	###
	$cmd "$file" "$expo" "$coll" "$name"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi

done

		
end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "2041-2060 process_monthly.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
