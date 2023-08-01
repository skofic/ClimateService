#!/bin/sh

###
# Save a collection to a file.
#
# The script expects the following parameters:
# - $1: Full file path of dump to export.
# - $2: Collection name.
#
# The dump will be a JSONL gzipped file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
expo="${path}/exports/"

###
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--collection "$2" \
	--output-directory "${expo}" \
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
mv --force "${expo}query.jsonl.gz" "${1}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
