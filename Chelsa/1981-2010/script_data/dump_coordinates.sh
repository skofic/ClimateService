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
expo="$path/exports/"
epoc="$path/Chelsa/1981-2010"

start=$(date +%s)

###
# Parameters.
###
coll="temp_bio"
file_name="coordinates_bio"
dump="${epoc}/data/properties/${file_name}.jsonl.gz"

###
# Export bioclimatic coordinates.
###
echo "----------------------------------------"
echo "==> Dump ${dump}"
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
mv --force "${expo}query.jsonl.gz" "$dump"	

###
# Parameters.
###
coll="temp_monthly"
file_name="coordinates_monthly"
dump="${epoc}/data/properties/${file_name}.jsonl.gz"

###
# Export monthly coordinates.
###
echo "----------------------------------------"
echo "==> Dump ${dump}"
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
mv --force "${expo}query.jsonl.gz" "$dump"	
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
