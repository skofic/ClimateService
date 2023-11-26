#!/bin/sh

###
# Fix precipitation data.
#
# This script will restore the original (wrong) Chelsa data
# dump the fixed data and restore it in Chelsa.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection="Chelsa"
database="GeoService"
dump="${path}/Data/Chelsa.jsonl.gz"
dump_new="${path}/Data/Chelsa_fixed.jsonl.gz"
query="${path}/Chelsa/fixes/dump_fix_precipitation.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** FIX_precipitation.sh"
echo "**************************************************"
echo "**************************************************"
FIX_PRECIPITATION_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Restore Chelsa data"
echo "*** from ${dump}"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$database" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$dump" \
	--type "jsonl" \
	--collection "$collection" \
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
echo "*** Dump corrected Chelsa data"
echo "*** to ${dump_new}"
echo "**************************************************"

###
# Dump corrected data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$database" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query" \
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
mv -f "${expo}/query.jsonl.gz" "$dump_new"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo ""
echo "**************************************************"
echo "*** Restore corrected Chelsa data"
echo "*** from ${dump_new}"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$database" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$dump_new" \
	--type "jsonl" \
	--collection "$collection" \
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

FIX_PRECIPITATION_END=$(date +%s)
elapsed=$((FIX_PRECIPITATION_END-FIX_PRECIPITATION_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** FIX_precipitation.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
