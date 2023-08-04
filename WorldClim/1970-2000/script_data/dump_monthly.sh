#!/bin/sh

###
# Dump monthly data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Dump monthly data."
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
file="combined_monthly"
epoc="${path}/WorldClim/1970-2000"
dump="${epoc}/data/properties/${file}.jsonl.gz"
query="${epoc}/script_query/dump_monthly.aql"

echo "----------------------------------------"
echo "==> Dump ${dump}"
start=$(date +%s)

###
# Export data to JSONL file.
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
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"