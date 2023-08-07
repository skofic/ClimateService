#!/bin/sh

###
# Dump annual data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Dump annual data."
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
file="combined_annual"
epoc="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
dump="${epoc}/data/properties/${file}.jsonl.gz"
query="${epoc}/script_query/dump_annual.aql"

echo "----------------------------------------"
echo "==> Dump ${dump}"
start=$(date +%s)

###
# Export data to JSONL file.
###
cmd="${path}/Chelsa/script_data/dump.sh"
$cmd "$dump" "$query" "{\"@@collection\": \"$coll\"}"
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
echo "2071-2100 dump_annual.sh"
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
