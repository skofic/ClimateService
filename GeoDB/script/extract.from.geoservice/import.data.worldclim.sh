#!/bin/sh

###
# Import Chelsa data.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
db="GeoDB"
name="WorldClim"
file="${path}/GeoDB/data/${name}.data.jsonl.gz"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> import.data.worldclim.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
START=$(date +%s)

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$db" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$file" \
	--type "jsonl" \
	--collection "$name" \
	--create-collection true \
	--create-collection-type "document" \
	--auto-rate-limit true \
	--overwrite true \
	--progress true
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
echo "==> import.data.worldclim.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
