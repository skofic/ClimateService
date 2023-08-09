#!/bin/sh

###
# Dump multi bio data to file.
#
# The script expects the following parameters:
# - $1: Full file path of dump to export.
# - $2: Full file path of import dump.
# - $3: Full file path of AQL query.
# - $4: Import collection name.
#
# The dump will be a JSONL gzipped file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Import file into database.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$2" \
	--type "csv" \
	--collection "$4" \
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
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "${expo}" \
	--custom-query-file "${3}" \
	--custom-query-bindvars "{\"@@collection\": \"${4}\"}" \
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
mv -f "${expo}/query.jsonl.gz" "${1}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
