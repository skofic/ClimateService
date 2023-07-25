#!/bin/sh

###
# Dump bioclimatic data.
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
file_data="combined_bio"
query_data="${epoc}/script_query/dump_bio.aql"

echo "----------------------------------------"
echo "==> Dump ${epoc}/data/properties/${file}.jsonl.gz"
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
	--custom-query-file "$query_data" \
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
mv --force "${expo}query.jsonl.gz" "${epoc}/data/properties/${file_data}.jsonl.gz"	
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
