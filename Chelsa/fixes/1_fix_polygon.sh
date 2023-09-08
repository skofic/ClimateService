#!/bin/sh

###
# Fix Polygon.
#
# This script will:
# - dump the Chelsa Map collection replacing the geometry with the polygon
# - dump the Chelsa Data collection adding the polygon
# Note that this script works on the GeoService database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection_map="ChelsaMap"
collection_data="Chelsa"
dump_map_name="ChelsaMap"
dump_chelsa_name="Chelsa"

###
# Parameters.
###
mdump="${path}/${dump_map_name}.jsonl.gz"
ddump="${path}/${dump_chelsa_name}.jsonl.gz"
mquery="${path}/Chelsa/fixes/dump_map.aql"
dquery="${path}/Chelsa/fixes/dump_data.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** 1_fix_polygon.sh"
echo "**************************************************"
echo "**************************************************"
ADD_POLYGON_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump Chelsa geometries"
echo "*** into ${path}/${dump_map_name}.jsonl.gz"
echo "**************************************************"

###
# Export Chelsa map to JSONL file, setting polygon as geometry.
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
# Move Chelsa data dump to its directory.
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
echo "*** Dump Chelsa properties"
echo "*** into ${path}/${dump_chelsa_name}.jsonl.gz"
echo "**************************************************"

###
# Export Chelsa data to JSONL file, adding polygon.
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

ADD_POLYGON_END=$(date +%s)
elapsed=$((ADD_POLYGON_END-ADD_POLYGON_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** 1_fix_polygon.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
