#!/bin/sh

###
# Dump 2071-2100 monthly data.
###

##–#
# Globals.
###
file="dump__monthly"
path="/usr/local/Chelsa/2071-2100/MPI-ESM1-2/ssp370"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"
expo="/usr/local/ArangoDB/exports/"
find="${path}/script/dump_monthly.aql"

echo "----------------------------------------"
echo "==> Dump ${path}/data/properties/${file}.jsonl.gz"
start=$(date +%s)
	
###
# Export data to CSV file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$1" \
	--server.username "$2" \
	--output-directory "$expo" \
	--custom-query-file "$find" \
	--overwrite true \
	--compress-output true \
	--type "jsonl"

###
# Move file to its directory.
###
mv --force "${expo}query.jsonl.gz" "${path}/data/properties/${file}.jsonl.gz"	
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
