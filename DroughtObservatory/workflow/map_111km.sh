#!/bin/sh

###
# Map files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
radius=0.03174691
collection="temp_pang"
epoc="${path}/DroughtObservatory"
dump="${epoc}/data/GDO_map_111km.jsonl.gz"
query="${epoc}/query/map.aql"

echo "=================================================="
echo "= MAP 111km FILES"
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
	--custom-query-bindvars "{\"@@collection\": \"$collection\", \"radius\": $radius}" \
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
echo "= MAP 111km FILES: $elapsed seconds"
echo "=================================================="
echo ""
