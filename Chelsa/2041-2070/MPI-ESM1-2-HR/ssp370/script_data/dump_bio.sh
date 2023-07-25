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
file="combined_bio"
expo="$path/exports/"
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
query="${epoc}/script_query/dump_bio.aql"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Dump ${dump}"
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
mv --force "${expo}query.jsonl.gz" "${dump}"	
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
