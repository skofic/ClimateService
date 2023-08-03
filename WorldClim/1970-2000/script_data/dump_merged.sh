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
file="properties"
epoc="${path}/WorldClim/1970-2000"
dump="${epoc}/${file}.jsonl.gz"
query="${path}/WorldClim/script_query/merge.aql"

echo "----------------------------------------"
echo "==> Dump $dump"
start=$(date +%s)

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
# Export map data.
###
cmd="${path}/WorldClim/script_data/save.sh"
$cmd "${epoc}/data/map.jsonl.gz" \
	 "$coll"
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
