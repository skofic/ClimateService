#!/bin/sh

###
# Dump merged dataset.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
coll="temp_pong"
epoc="$path/Chelsa/1981-2010"
cmd="${path}/Chelsa/script_data/dump.sh"

echo "----------------------------------------"
echo "==> Dump $dump"
start=$(date +%s)

###
# Export merged data.
###
$cmd "${epoc}/properties.jsonl.gz" \
	 "${path}/Chelsa/script_query/merge.aql" \
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
