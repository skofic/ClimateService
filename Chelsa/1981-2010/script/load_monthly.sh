#!/bin/sh

###
# Load 1981-2010 monthly data.
###

##–#
# Globals.
###
coll="Chelsa_1981_2010_monthly"
file="dump_1981_2010_monthly"
path="/usr/local/Chelsa/1981-2010"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"

echo "----------------------------------------"
echo "==> Load ${coll}"
start=$(date +%s)
	
###
# Import data from JSONL file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$1" \
	--server.username "$2" \
	--file "${path}/data/properties/${file}.jsonl.gz" \
	--type "jsonl" \
	--collection "$coll" \
	--create-collection true \
	--create-collection-type "document" \
	--overwrite true
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
