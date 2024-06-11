#!/bin/sh

###
# Normalise Chelsa.
#
# This script will:
# - dump the Chelsa collection removing the geometry_hash peoperty
# - load the dumped collection back into Chelsa.
# Note that this script works on the GeoService database.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

###
# Create data directory.
###
mkdir -p "${path}/Data"

###
# Globals.
###
collection="Chelsa"
dump_name="Chelsa"

###
# Parameters.
###
dump="${path}/Data/${dump_name}.jsonl.gz"
query="${path}/Chelsa/fixes/NormaliseChelsa.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** normalise_chelsa.sh"
echo "**************************************************"
echo "**************************************************"
NORMALISE_CHELSA_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump Chelsa"
echo "*** into ${dump}"
echo "**************************************************"

###
# Export Chelsa to JSONL file, removing geometry_hash property.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
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

###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
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

NORMALISE_CHELSA_END=$(date +%s)
elapsed=$((NORMALISE_CHELSA_END-NORMALISE_CHELSA_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** normalise_chelsa.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
