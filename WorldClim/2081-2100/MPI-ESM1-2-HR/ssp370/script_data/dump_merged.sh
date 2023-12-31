#!/bin/sh

###
# Dump merged dataset.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Dump merged period"
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
epoc="${path}/WorldClim/2081-2100/MPI-ESM1-2-HR/ssp370"

echo "--------------------------------------------------"
echo "==> Dump $dump"
start=$(date +%s)

###
# Properties.
###
file="properties"
dump="${epoc}/data/${file}.jsonl.gz"
query="${path}/WorldClim/script_query/merge.aql"

###
# Export merged data.
###
cmd="${path}/WorldClim/script_data/dump.sh"
$cmd "$dump" "$query" "{\"@@collection\": \"$coll\"}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Properties.
###
file="map"
dump="${epoc}/data/${file}.jsonl.gz"

###
# Export map data.
###
cmd="${path}/WorldClim/script_data/save.sh"
$cmd "$dump" "$coll"
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
echo "2081-2100 dump_merged.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
