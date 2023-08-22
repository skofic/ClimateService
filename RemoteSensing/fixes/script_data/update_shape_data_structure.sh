#!/bin/sh

###
# Update ShapeData structure.
#
# The script wil:
# - Update GeometryID to geo_shape_id.
# - Aggregate all properties into a 'properties' property.
#
# The script expects the following parameters:
# - $1: Database name.
# - $2: Collection name.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Set path parameters.
###
epoc="$path/RemoteSensing/fixes"

###
# Dump updated GeometryID name and create properties struct.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$1" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${epoc}/script_query/update_shape_data_structure.aql" \
	--custom-query-bindvars "{\"@@collection\": \"$2\"}" \
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
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$1" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "${expo}/query.jsonl.gz" \
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
