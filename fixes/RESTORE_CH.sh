#!/bin/sh

###
# Restore ShapeData and DroughtObservatory.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

###
# Globals.
###
collection_rs="ShapeData"
collection_do="DroughtObservatory"
bdir_rs="/home/geouser/Backup/RemoteSensing"
bdir_do="/home/geouser/Backup/DroughtObservatory"

###
# Parameters.
###
dump_rs="${bdir_rs}/${collection_rs}.jsonl.gz"
dump_do="${bdir_do}/${collection_do}.jsonl.gz"

echo "**************************************************"
echo "**************************************************"
echo "*** RESTORE_CH.sh"
echo "**************************************************"
echo "**************************************************"
RESTORE_DATA_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Restore ShapeData"
echo "*** from $dump_rs"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$dump_rs" \
	--type "jsonl" \
	--collection "$collection_rs" \
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
echo "*** Restore DroughtObservatory"
echo "*** from $dump_do"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$dump_do" \
	--type "jsonl" \
	--collection "$collection_do" \
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
echo "*** RESTORE_CH.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
