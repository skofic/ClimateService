#!/bin/sh

###
# Process monthly files, set variable, scale and offset.
# Multiple bands version.
#
# The script expects the following parameters:
# - $1: Full file path of dump to import.
# - $2: Full file path of processed CSV data.
# - $3: Import/export collection name.
# - $4: variable base name.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
head="${path}/WorldClim/config/header_monthly.csv"
query="${path}/WorldClim/script_query/process_multi_monthly.aql"

###
# Import file into database.
# Translate variable names to descriptor names.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$1" \
	--headers-file "$head" \
	--type "csv" \
	--collection "$3" \
	--auto-rate-limit true \
	--ignore-missing \
	--overwrite
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Export data to CSV file.
# Scale bio04 value and set descriptor names.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query" \
	--custom-query-bindvars "{\"@@collection\": \"$3\", \"variable\": \"${pref}_${4}\"}" \
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

###
# Move file to its directory.
###
mv -f "${expo}/query.jsonl.gz" "$2"	
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
