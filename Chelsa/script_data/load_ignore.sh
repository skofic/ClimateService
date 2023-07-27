#!/bin/sh

###
# Load points into collection ignoring duplicates
#
# The script expects the following parameters:
# - $1: Full file path of dump to import.
# - $2: Name of collection into which to write.
#
# The collection type is assumed to be document,
# the document type is assumed to be JSONL
# and eventual duplicate errors are ignored.
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
	--auto-rate-limit true \
	--on-duplicate "ignore"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
