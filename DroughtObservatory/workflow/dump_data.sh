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
base="GeoService"
collection="DroughtObservatory"
epoc="${path}/DroughtObservatory"
dump="${epoc}/data/${collection}.jsonl.gz"

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
	--collection "$collection" \
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
mv -f "${expo}/${collection}.jsonl.gz" "$dump"
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
