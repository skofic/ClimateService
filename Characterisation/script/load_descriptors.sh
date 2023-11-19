#!/bin/sh

###
# LOAD DATA.
#
# Iterate all csv descriptor data files
# and explode data by gcu, species and date.
#
# The script expects the following parameters:
# - $1: Dataset unique identifier.
# - $2: List of descriptor data files.
# - $3: Name of query file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
query="${path}/Characterisation/query/${3}"

###
# Iterate list of files.
###
collection="temp_ping"
while read -r line
do
	
	###
	# Set CSV file path.
	###
	csv="${path}/Characterisation/data/CSV/${line}.csv"
	dump="${path}/Characterisation/data/JSON/${line}.jsonl.gz"
	
	echo "==> IMPORT ${csv}"
	
	###
	# Import data from CSV file.
	###
	arangoimport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--file "$csv" \
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
	
	echo "==> DUMP ${dump}"
	
	###
	# Export data to JSONL file.
	###
	arangoexport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--output-directory "${expo}" \
		--custom-query-file "${query}" \
		--custom-query-bindvars "{\"@@collection\": \"${collection}\", \"uuid\": \"${1}\", \"variable\": \"${line}\"}" \
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
	mv -f "${expo}/query.jsonl.gz" "${dump}"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
  
done < "$2"
