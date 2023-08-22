#!/bin/sh

###
# Update unit shapes (UnitShapes) variable names.
#
# The script wil:
# - Update the variable names.
# - Convert the shape reference from an _id to a _key.
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
# Dump updated GeometryID name and create properties struct.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${epoc}/script_query/update_unit_shapes.aql" \
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
