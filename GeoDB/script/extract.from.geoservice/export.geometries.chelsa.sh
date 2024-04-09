#!/bin/sh

###
# Export Chelsa geometries.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
file="${path}/GeoDB/data/1.geometries.chelsa.jsonl.gz"
query="${path}/GeoDB/script/extract.from.geoservice/aql/Chelsa.aql"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export.geometries.chelsa.sh"
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
	--output-directory "$expo" \
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
mv -f "${expo}/query.jsonl.gz" "$file"
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
echo "==> export.geometries.chelsa.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
