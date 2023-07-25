#!/bin/sh

###
# Load coordinates in collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="Climate"
coll="temp_pong"
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"

echo "----------------------------------------"
echo "==> Load ${coll}"
start=$(date +%s)

###
# Import bioclimatic coordinates from JSONL file.
# Note that here we use the temp_pong collection and we clear it,
# a good thing, since it is holding more than 2 billion records...
###
file_name="coordinates_bio"
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "${epoc}/data/properties/${file_name}.jsonl.gz" \
	--type "jsonl" \
	--collection "$coll" \
	--create-collection true \
	--create-collection-type "document" \
	--auto-rate-limit true \
	--overwrite true
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Import monthly coordinates from JSONL file.
###
file_name="coordinates_monthly"
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "${epoc}/data/properties/${file_name}.jsonl.gz" \
	--type "jsonl" \
	--collection "$coll" \
	--auto-rate-limit true \
	--on-duplicate "ignore"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
