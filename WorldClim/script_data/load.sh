#!/bin/sh

###
# Load dump file into collection.
#
# The script expects the following parameters:
# - $1: Full file path of dump to import.
# - $2: Name of collection into which to write.
#
# The collection type is assumed to be document,
# the document type is assumed to be JSONL
# and the collection will be cleared prior to loading.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$1" \
	--type "jsonl" \
	--collection "$2" \
	--create-collection true \
	--create-collection-type "document" \
	--auto-rate-limit true \
	--overwrite true
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
