#!/bin/sh

###
# Merge daily data and dump result.
#
# Parameters:
# - $1: Merge data collection.
#
# The script will combine all data from merge collection
# grouping by shape hash, period span and date.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
span="std_date_span_day"

echo "=================================================="
echo "= merge_daily_data.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
merge_daily_data_start=$(date +%s)

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>> Merge monthly data and dump ${span}."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
###
# Load data in temporary collection.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${path}/RemoteSensing/queries/merge.aql" \
	--custom-query-bindvars "{\"@@collection\": \"${1}\"}" \
	--compress-output true \
	--overwrite true \
	--type "jsonl"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>> Move ${span}.jsonl.gz to DATA directory."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
###
# Move file to its directory.
###
mv -f "${expo}/query.jsonl.gz" "${path}/RemoteSensing/data/${span}.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

merge_daily_data_end=$(date +%s)
elapsed=$((merge_daily_data_end-merge_daily_data_start))
echo "=================================================="
echo "= merge_daily_data.sh duration: $elapsed seconds"
echo "=================================================="
echo ""
