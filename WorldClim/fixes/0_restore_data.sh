#!/bin/sh

###
# Load data.
#
# This script will restore the WorldClim and WorldClimMap dumps into the database.
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
echo "*** 0_restore_data.sh"
echo "**************************************************"
echo "**************************************************"
RESTORE_DATA_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Restore WorldClim geometries"
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
echo "*** Restore WorldClim properties"
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

RESTORE_DATA_END=$(date +%s)
elapsed=$((RESTORE_DATA_END-RESTORE_DATA_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** 0_restore_data.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
