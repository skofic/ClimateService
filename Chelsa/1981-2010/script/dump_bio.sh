#!/bin/sh

###
# Dump bioclimatic data.
###

###
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

###
# Globals.
###
base="Climate"
file="dump_1981_2010_bio"
epoc="$path/Chelsa/1981-2010"
expo="$path/exports/"
find="${epoc}/script/dump_bio.aql"

echo "----------------------------------------"
echo "==> Dump ${epoc}/data/properties/${file}.jsonl.gz"
start=$(date +%s)
	
###
# Export data to CSV file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$find" \
	--overwrite true \
	--compress-output true \
	--type "jsonl"

###
# Move file to its directory.
###
mv --force "${expo}query.jsonl.gz" "${epoc}/data/properties/${file}.jsonl.gz"	
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
