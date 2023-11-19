#!/bin/sh

###
# GROUP DATA.
#
# Group individual data by gcu, species and date.
# JSON dump version.
#
# The script expects the following parameters:
# - $1: Dataset code or acronym.
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
output="${path}/Characterisation/data/DUMP/DATA_${1}.json"

###
# Load data in grouping collection.
###
first=1
collection="temp_pong"
while read -r line
do
	
	###
	# Set CSV file path.
	###
	dump="${path}/Characterisation/data/JSON/${line}.jsonl.gz"
	
	###
	# Export data to JSONL file.
	###
	if [ $first -eq 1 ]
	then
		first=0
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$dump" \
			--type "jsonl" \
			--collection "$collection" \
			--auto-rate-limit true \
			--overwrite
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	else
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$dump" \
			--type "jsonl" \
			--collection "$collection" \
			--auto-rate-limit true
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	fi
  
done < "$2"

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
	--custom-query-bindvars "{\"@@collection\": \"${collection}\"}" \
	--overwrite true \
	--type "json"
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
mv -f "${expo}/query.json" "${output}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
