#!/bin/sh

###
# Export ShapeData geometries.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
name="ShapeData"
file="${path}/GeoDB/data/${name}.geometry.jsonl.gz"
cache="${expo}/geometry"
query="${path}/GeoDB/script/extract.from.geoservice/aql/${name}.geometry.aql"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export.geometries.rs.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
START=$(date +%s)

###
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$cache" \
	--custom-query-file "$query" \
	--type "jsonl" \
	--compress-output true \
	--overwrite true \
	--progress true
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
mv -f "${cache}/query.jsonl.gz" "$file"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

END=$(date +%s)
elapsed=$((END-START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export.geometries.rs.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
