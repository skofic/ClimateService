#!/bin/sh

###
# Process multi-band bioclimatic variables.
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
echo "= Process bioclimatic data."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
epoc="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"
cmd="${path}/WorldClim/script_data/process_multi_bio.sh"

###
# Parameters.
###
name="bio"
file="${epoc}/CSV/${name}.csv.gz"
expo="${epoc}/data/${name}.csv.gz"

start=$(date +%s)
echo "==> $expo"

###
# Process converted CSV data.
###
$cmd "$file" "$expo" "$coll"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
