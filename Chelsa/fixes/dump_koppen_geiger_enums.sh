#!/bin/sh

###
# Fix Köppen/Geiger enumerations.
#
# This script will:
# - dump the Chelsa collection correcting the Köppen/Geiger enumerations
# - load the dumped collection back into Chelsa.
# Note that this script works on the GeoService database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Create data directory.
###
mkdir -f "${path}/Data"

###
# Globals.
###
collection="Chelsa"
dump_name="Chelsa"

###
# Parameters.
###
dump="${path}/Data/${dump_name}.jsonl.gz"
query="${path}/Chelsa/fixes/dump_koppen_geiger.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** dump_koppen_geiger_enums.sh"
echo "**************************************************"
echo "**************************************************"
DUMP_KOPPEN_GEIGER_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump Chelsa corrected Köppen/Geiger enumerations"
echo "*** into ${path}/${dump_name}.jsonl.gz"
echo "**************************************************"

###
# Export Chelsa to JSONL file, correcting enumerations.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${query}" \
	--custom-query-bindvars "{\"@@collection\": \"$collection\"}" \
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
mv -f "${expo}/query.jsonl.gz" "$dump"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

DUMP_KOPPEN_GEIGER_END=$(date +%s)
elapsed=$((DUMP_KOPPEN_GEIGER_END-DUMP_KOPPEN_GEIGER_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** dump_koppen_geiger_enums.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
