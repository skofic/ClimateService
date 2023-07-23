#!/bin/sh

###
# Load bioclimatic data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="Climate"
coll="temp_bio"
file="dump_1981_2010_bio"
epoc="$path/Chelsa/1981-2010"

echo "----------------------------------------"
echo "==> Load ${coll}"
start=$(date +%s)
	
###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "${epoc}/data/properties/${file}.jsonl.gz" \
	--type "jsonl" \
	--collection "$coll" \
	--create-collection true \
	--create-collection-type "document" \
	--auto-rate-limit true \
	--overwrite true
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
