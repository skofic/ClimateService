#!/bin/sh

###
# Import Chelsa geometry.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
db="GeoDB"
name="Chelsa"
file="/home/ArangoDB/export/GeoDB/GeoDB.${name}.geometry.jsonl.gz"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> import.data.chelsa.sh"
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
	--collection "GEOMETRY" \
	--create-collection true \
	--create-collection-type "document" \
	--overwrite true \
	--progress true
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
# 	--auto-rate-limit true \

END=$(date +%s)
elapsed=$((END-START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> import.data.chelsa.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
