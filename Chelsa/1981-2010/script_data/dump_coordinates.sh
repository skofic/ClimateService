#!/bin/sh

###
# Dump data coordinates.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="$path/Chelsa/1981-2010"
cmd="${path}/Chelsa/script_data/dump.sh"

start=$(date +%s)

###
# Parameters.
###
coll="temp_annual"
file="coordinates_annual"

###
# Export annual coordinates.
###
echo "----------------------------------------"
echo "==> Dump ${dump}"
$cmd "${epoc}/data/properties/${file}.jsonl.gz" \
	 "${path}/Chelsa/script_query/export_points.aql" \
	 '{"@@collection": "$3"}'
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Parameters.
###
coll="temp_monthly"
file="coordinates_monthly"

###
# Export monthly coordinates.
###
echo "----------------------------------------"
echo "==> Dump ${dump}"
$cmd "${epoc}/data/properties/${file}.jsonl.gz" \
	 "${path}/Chelsa/script_query/export_points.aql" \
	 "{@@collection: $coll}"
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
