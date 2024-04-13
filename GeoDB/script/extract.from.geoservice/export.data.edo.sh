#!/bin/sh

###
# Export DroughtObservatory data.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
name="DroughtObservatory"
file="${path}/GeoDB/data/${name}.data.jsonl.gz"
cache="${expo}/data"
query="${path}/GeoDB/script/extract.from.geoservice/aql/${name}.data.aql"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export.data.edo.sh"
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
echo "==> export.data.edo.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
