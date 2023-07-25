#!/bin/sh

###
# Dump data coordinates.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="Climate"
epoc="$path/Chelsa/1981-2010"
expo="$path/exports/"

echo "----------------------------------------"
echo "==> Dump ${epoc}/data/properties/${file}.jsonl.gz"
start=$(date +%s)

###
# Export bioclimatic coordinates.
###
coll="temp_bio"
file_name="coordinates_bio"
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query "FOR doc IN ${coll} RETURN {_key: doc._key, geometry: doc.geometry}" \
	--overwrite true \
	--compress-output true \
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
mv --force "${expo}query.jsonl.gz" "${epoc}/data/properties/${file_name}.jsonl.gz"	

###
# Export data to JSONL file.
###
coll="temp_monthly"
file_name="coordinates_monthly"
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query "FOR doc IN ${coll} RETURN {_key: doc._key, geometry: doc.geometry}" \
	--overwrite true \
	--compress-output true \
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
mv --force "${expo}query.jsonl.gz" "${epoc}/data/properties/${file_name}.jsonl.gz"	
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
