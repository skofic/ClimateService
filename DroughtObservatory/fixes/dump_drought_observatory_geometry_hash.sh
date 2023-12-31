#!/bin/sh

###
# Dump drought observatory with geometry hash.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="GeoService"
collection="DroughtObservatory"
epoc="${path}/DroughtObservatory"
dump="${epoc}/data/${collection}.jsonl.gz"
query="${epoc}/fixes/dump_drought_observatory_geometry_hash.aql"

###
# Create directories.
###
cmd="${epoc}/workflow/create_directories.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo "=================================================="
echo "= DUMP DATA FILE"
echo "=================================================="
start=$(date +%s)

###
# Export data to JSONL file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query" \
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
# Move file to its directory.
###
mv -f "${expo}/query.jsonl.gz" "$dump"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= DUMP DATA FILE: $elapsed seconds"
echo "=================================================="
echo ""
