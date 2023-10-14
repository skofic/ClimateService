#!/bin/sh

###
# Load Köppen/Geiger enumerations.
#
# This script will load the Chelsa corrected Köppen/Geiger enumerations.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection="Chelsa"
dump_name="Chelsa"

###
# Parameters.
###
dump="${path}/Data/${dump_name}.jsonl.gz"

echo "**************************************************"
echo "**************************************************"
echo "*** load_koppen_geiger.sh"
echo "**************************************************"
echo "**************************************************"
LOAD_KOPPEN_GEIGER_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Load Chelsa dump"
echo "*** from ${path}/${dump_name}.jsonl.gz"
echo "**************************************************"

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
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

LOAD_KOPPEN_GEIGER_END=$(date +%s)
elapsed=$((LOAD_KOPPEN_GEIGER_END-LOAD_KOPPEN_GEIGER_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** load_koppen_geiger.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
