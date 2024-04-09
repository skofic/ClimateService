#!/bin/sh

###
# Export DroughtObservatory geometries.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
file="${path}/GeoDB/data/3.geometries.edo.jsonl.gz"
query="${path}/GeoDB/script/extract.from.geoservice/aql/DroughtObservatory.aql"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export.geometries.edo.sh"
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
echo "==> export.geometries.edo.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
