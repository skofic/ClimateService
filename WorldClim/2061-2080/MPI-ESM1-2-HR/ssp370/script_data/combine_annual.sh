#!/bin/sh

###
# Combine multi-band bioclimatic variables.
#
# The script will convert the CSV dump into the final JSONL format.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Combine bioclimatic data."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
name="combined_annual"
epoc="${path}/WorldClim/2061-2080/MPI-ESM1-2-HR/ssp370"
cmd="${path}/WorldClim/script_data/combine_multi_bio.sh"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Parameters.
###
file="${epoc}/data/bio.csv.gz"
expo="${epoc}/data/properties/${name}.jsonl.gz"
query="${epoc}/script_query/merge_bio.aql"

###
# Load and dump bioclimatic data.
###
$cmd "$expo" "$file" "$query" "$coll"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
		
end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "2061-2080 combine_bio.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
