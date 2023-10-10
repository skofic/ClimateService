#!/bin/sh

###
# Update descriptors for GeoService Shapes collection
#
# The script will write the updated dump of the collection.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
UPDATE_START=$(date +%s)

###
# Set custom parameters.
###
coll="Shapes"
dump="${path}/Data"
query="${path}/fixes/update_shapes.aql"

###
# Create directory.
###
mkdir -p "${dump}"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> UPDATE_Shapes.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""

###
# Dump with changes.
##
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${query}" \
	--custom-query-bindvars "{\"@@collection\": \"$coll\"}" \
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
# Move file to its directory.
###
mv -f "${expo}/query.jsonl.gz" "${dump}/${coll}.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

UPDATE_END=$(date +%s)
elapsed=$((UPDATE__END-UPDATE_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> UPDATE_Shapes.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
