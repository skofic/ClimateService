#!/bin/sh

###
# Dump data with fixed variable names and data structure.
#
# The script expects the following parameters:
# - $1: Collection name.
# - $2: Path to AQL file.
#
# This script assumes the only bind variable to pass is the collection name.
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
# Dump updated data.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$2" \
	--custom-query-bindvars "{\"@@collection\": \"$1\"}" \
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
# Move and rename dump into data directory.
###
mv -f "${expo}/query.jsonl.gz" "${epoc}/data/${1}.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
