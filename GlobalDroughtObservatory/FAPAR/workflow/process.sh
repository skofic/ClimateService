#!/bin/sh

###
# Process CSV files and place them in the data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/GlobalDroughtObservatory/FAPAR"
head="${path}/GlobalDroughtObservatory/config/header.csv"
variable="env_climate_fapar"

###
# Parameters.
###
collection="temp_ping"
query="${path}/GlobalDroughtObservatory/query/process.aql"

echo "--------------------------------------------------"
echo "- PROCESS FAPAR FILES"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate CSV files.
###
for file in "${epoc}/CSV/"*.csv
do
	
	###
	# Get date from filename.
	###
	name=$(basename -- "$file" .csv)

	echo ""
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> IMPORT FAPAR/CSV/${name}.csv"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	
	###
	# Import file into database.
	###
	arangoimport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--file "$file" \
		--headers-file "$head" \
		--type "csv" \
		--collection "$collection" \
		--auto-rate-limit true \
		--ignore-missing \
		--overwrite
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> PROCESS FAPAR/data/${name}.jsonl"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	
	###
	# Set destination file path.
	###
	dest="${epoc}/data/${name}.jsonl.gz"

	###
	# Export data into data folder.
	###
	arangoexport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--output-directory "$expo" \
		--custom-query-file "$query" \
		--custom-query-bindvars "{\"@@collection\": \"$collection\", \"variable\": \"${variable}\", \"date\": \"${name}\"}" \
		--compress-output true \
		--overwrite true \
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
	mv -f "${expo}/query.jsonl.gz" "$dest"	
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
done

echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"
echo "␡ DELETE imported files"
echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"

###
# Iterate CSV files.
###
for file in "${epoc}/CSV/"*.csv
do
	
	###
	# Delete file.
	###
	rm -f "$file"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi

done

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "--------------------------------------------------"
echo "- PROCESS FAPAR FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
