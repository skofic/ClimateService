#!/bin/sh

###
# Load data.
#
# This script will load the WorldClim and WorldClimMap dumps into the database.
# Note that this script works on the GeoService database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection_map="WorldClimMap"
collection_data="WorldClim"
dump_map_name="WorldClimMap"
dump_worldclim_name="WorldClim"

###
# Parameters.
###
mdump="${path}/${dump_map_name}.jsonl.gz"
ddump="${path}/${dump_worldclim_name}.jsonl.gz"

echo "**************************************************"
echo "**************************************************"
echo "*** 2_load_data.sh"
echo "**************************************************"
echo "**************************************************"
LOAD_DATA_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Load WorldClim geometries"
echo "*** from ${path}/${dump_map_name}.jsonl.gz"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$mdump" \
	--type "jsonl" \
	--collection "$collection_map" \
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

echo ""
echo "**************************************************"
echo "*** Load WorldClim properties"
echo "*** from ${path}/${dump_worldclim_name}.jsonl.gz"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$ddump" \
	--type "jsonl" \
	--collection "$collection_data" \
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

LOAD_DATA_END=$(date +%s)
elapsed=$((LOAD_DATA_END-LOAD_DATA_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** 2_load_data.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
