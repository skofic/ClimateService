#!/bin/sh

###
# Restore DroughtObservatory.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

###
# Globals.
###
collection_do="DroughtObservatory"
bdir_do="/home/geouser/Backup/DroughtObservatory"

###
# Parameters.
###
dump_do="${bdir_do}/${collection_do}.jsonl.gz"

echo "**************************************************"
echo "**************************************************"
echo "*** RESTORE_DO.sh"
echo "**************************************************"
echo "**************************************************"
RESTORE_DATA_START=$(date +%s)

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
echo "*** RESTORE_DO.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
