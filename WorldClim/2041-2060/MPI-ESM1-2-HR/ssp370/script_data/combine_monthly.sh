#!/bin/sh

###
# Combine multi-band monthly variables.
#
# The script will convert the CSV dump into the final JSONL format.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Combine monthly data."
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
file="combined_monthly"
epoc="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"
expo="${epoc}/data/properties/${file}.jsonl.gz"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate monthly files and stack in temp_pong.
###
first=1
cmd="${path}/WorldClim/script_data/combine_multi_monthly.sh"
for name in "pr" "tasmax" "tasmin"
do

	###
	# Stack monthly file.
	##
	$cmd "${epoc}/data/${name}.jsonl.gz" "$coll" $first
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	first=0

done

###
# Combine into monthly data.
###
		
end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "2041-2060 combine_monthly.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
