#!/bin/sh

###
# Process elevation data.
#
# The script will process elevation data and dump
# the file that will be used when merging WorldClim data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Process elevation."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
name="geo_shape_elevation"
epoc="${path}/WorldClim/Elevation"

echo "---------------------------------------------------------------------"
echo "- Load elevation CSV into database."
echo "---------------------------------------------------------------------"
	
###
# Properties.
###
file="properties"
dump="${epoc}/data/${file}.jsonl.gz"
impo="${epoc}/CSV/elevation.csv.gz"
head="${path}/WorldClim/config/header_single.csv"
query="${path}/WorldClim/script_query/merge_elevation.aql"

###
# Import file into database.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$impo" \
	--headers-file "$head" \
	--type "csv" \
	--collection "$coll" \
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

echo "---------------------------------------------------------------------"
echo "- Export elevation data dump."
echo "---------------------------------------------------------------------"
	
###
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query" \
	--custom-query-bindvars "{\"@@collection\": \"$coll\", \"variable\": \"${name}\"}" \
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
mv -f "${expo}/query.jsonl.gz" "$dump"	
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo "---------------------------------------------------------------------"
echo "- Export elevation coordinates dump."
echo "---------------------------------------------------------------------"
	
###
# Properties.
###
file="map"
dump="${epoc}/data/${file}.jsonl.gz"
query="${path}/WorldClim/script_query/export_geometries.aql"

###
# Export coordinates to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query" \
	--custom-query-bindvars "{\"@@collection\": \"$coll\"}" \
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
mv -f "${expo}/query.jsonl.gz" "$dump"	
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
