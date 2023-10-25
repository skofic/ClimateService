#!/bin/sh

###
# Dump Shapes collection as GeoJSON.
#
# Note: this script uses GeoService database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Yearly data dictionary.
###

echo "=================================================="
echo "= DumpShapesGeoJSON.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""

###
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${path}/RemoteSensing/queries/Shapes_GeoJSON_export.aql" \
	--compress-output false \
	--overwrite true \
	--type "json"
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
mv -f "${expo}/query.json" "${path}/RemoteSensing/shapes/Shapes.geojson"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
