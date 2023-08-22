#!/bin/sh

###
# Update shape (Shapes) variable names and remove NULL topography variables.
#
# The script will iterate all records, tracking which topography variables
# are not NULL, it will then return the record with updated variable names
# and only the topography variables that are not NULL.
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
# Dump updated variable names and non-null topography properties.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${epoc}/script_query/update_shapes.aql" \
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
# Copy and rename dump into data directory.
###
# cp -f "${expo}/query.jsonl.gz" "${epoc}/data/${1}.jsonl.gz"
mv -f "${expo}/query.jsonl.gz" "${epoc}/data/${1}.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

# ###
# # Import data from JSONL file.
# ###
# arangoimport \
# 	--server.endpoint "$host" \
# 	--server.database "$base" \
# 	--server.username "$user" \
# 	--server.password "$pass" \
# 	--file "${expo}/query.jsonl.gz" \
# 	--type "jsonl" \
# 	--collection "$1" \
# 	--create-collection true \
# 	--create-collection-type "document" \
# 	--auto-rate-limit true \
# 	--overwrite true
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi
