#!/bin/sh

###
# Load remote sensing shapes with dataset references.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="GeoService"
collection="Shapes"
epoc="${path}/RemoteSensing"
dump="${epoc}/fixes/data/${collection}.jsonl.gz"

echo "=================================================="
echo "= LOAD SHAPE FILE"
echo "=================================================="
start=$(date +%s)

###
# Import data to collection.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$dump" \
	--type "jsonl" \
	--collection "$collection" \
	--auto-rate-limit true \
	--create-collection false \
	--overwrite true
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
echo "= LOAD SHAPE FILE: $elapsed seconds"
echo "=================================================="
echo ""
