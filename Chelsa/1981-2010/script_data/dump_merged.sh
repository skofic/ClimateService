#!/bin/sh

###
# Dump merged dataset.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="Climate"
name="properties"
query="merge.aql"
expo="$path/exports/"
epoc="$path/Chelsa/1981-2010"
dump="${epoc}/${name}.jsonl.gz"

echo "----------------------------------------"
echo "==> Dump $dump"
start=$(date +%s)

###
# Export merged data.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${path}/Chelsa/config/${query}" \
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
