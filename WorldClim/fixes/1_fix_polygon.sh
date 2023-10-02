#!/bin/sh

###
# Fix Polygon.
#
# This script will:
# - dump the WorldClim Map collection replacing the geometry with the polygon
# - dump the WorldClim Data collection adding the polygon
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
mquery="${path}/WorldClim/fixes/dump_map.aql"
dquery="${path}/WorldClim/fixes/dump_data.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** 1_fix_polygon.sh"
echo "**************************************************"
echo "**************************************************"
FIX_POLYGON_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump WorldClim geometries"
echo "*** into ${path}/${dump_map_name}.jsonl.gz"
echo "**************************************************"

###
# Export WorldClim map to JSONL file, setting polygon as geometry.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${mquery}" \
	--custom-query-bindvars "{\"@@collection\": \"$collection_map\"}" \
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
# Move WorldClim data dump to its directory.
###
mv -f "${expo}/query.jsonl.gz" "$mdump"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo ""
echo "**************************************************"
echo "*** Dump WorldClim properties"
echo "*** into ${path}/${dump_worldclim_name}.jsonl.gz"
echo "**************************************************"

###
# Export WorldClim data to JSONL file, adding polygon.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${dquery}" \
	--custom-query-bindvars "{\"@@collection\": \"$collection_data\"}" \
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
# Move Chelsa data dump to its directory.
###
mv -f "${expo}/query.jsonl.gz" "$ddump"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

FIX_POLYGON_END=$(date +%s)
elapsed=$((FIX_POLYGON_END-FIX_POLYGON_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** 1_fix_polygon.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
