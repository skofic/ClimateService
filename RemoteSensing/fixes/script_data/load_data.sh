#!/bin/sh

###
# Load fixed data into collection.
#
# The script expects the following parameters:
# - $1: Collection name.
#
# You should delete the old indexes, before running the script,
# and re-create the indexes, with the new variable names,
# after running the script.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

###
# Set path parameters.
###
epoc="$path/RemoteSensing/fixes"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "${epoc}/data/${1}.jsonl.gz" \
	--type "jsonl" \
	--collection "$1" \
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
