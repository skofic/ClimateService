#!/bin/sh

###
# Normalise WorldClim.
#
# This script will:
# - dump the WorldClim collection removing the geometry_hash peoperty
# - load the dumped collection back into WorldClim.
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
collection="WorldClim"
dump_name="WorldClim"

###
# Parameters.
###
dump="${path}/Data/${dump_name}.jsonl.gz"
query="${path}/WorldClim/fixes/NormaliseWorldClim.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** normalise_worldclim.sh"
echo "**************************************************"
echo "**************************************************"
NORMALISE_WORLDCLIM_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump WorldClim"
echo "*** into ${dump}"
echo "**************************************************"

###
# Export WorldClim to JSONL file, removing geometry_hash property.
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
# Move WorldClim data dump to its directory.
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

NORMALISE_WORLDCLIM_END=$(date +%s)
elapsed=$((NORMALISE_WORLDCLIM_END-NORMALISE_WORLDCLIM_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** normalise_worldclim.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
