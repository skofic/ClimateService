#!/bin/sh

###
# Dump annual data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
coll="temp_pong"
file="combined_annual"
epoc="${path}/Chelsa/1981-2010"
cmd="${path}/Chelsa/script_data/dump.sh"

echo "----------------------------------------"
echo "==> Dump ${dump}"
start=$(date +%s)

###
# Export data to JSONL file.
###
$cmd "${epoc}/data/properties/${file}.jsonl.gz" \
	 "${epoc}/script_query/dump_annual.aql" \
	 '{"@@collection": "$3"}'
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
