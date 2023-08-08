#!/bin/sh

###
# Dump query data to a file.
#
# The script expects the following parameters:
# - $1: Full file path of dump to export.
# - $2: Full file path of AQL query.
# - $3: Bind variables dictionary.
#
# The dump will be a JSONL gzipped file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "${expo}" \
	--custom-query-file "${2}" \
	--custom-query-bindvars "${3}" \
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
