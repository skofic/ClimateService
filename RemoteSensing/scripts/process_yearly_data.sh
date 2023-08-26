#!/bin/sh

###
# Process yearly data and save in temp_annual collection.
#
# Parameters:
# - $1: Temporary cache collection.
# - $2: stack data collection.
# - $3: Full path to the yearly data dictionary.
#
# The script will iterate all yearly data files,
# it will load the current file in a temp collection,
# dump the data with a new structure and with eventual processing,
# and finally load all processed yearly data into the temp_annual collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
span="std_date_span_year"

echo "=================================================="
echo "= process_yearly_data.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
process_yearly_data_start=$(date +%s)

###
# Set path parameters.
###
first=1
epoc="${path}/RemoteSensing/CSV"

###
# Iterate yearly files.
###
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    filename=$(echo $line | cut -d ' ' -f 1)
    variable=$(echo $line | cut -d ' ' -f 2)
    headname=$(echo $line | cut -d ' ' -f 3)
    quername=$(echo $line | cut -d ' ' -f 4)
    
	echo "--------------------------------------------------"
	echo "- Processing:"
	echo "  - File name:         :$filename"
	echo "  - Variable name:     :$variable"
	echo "  - Header value name: :$headname"
	echo "  - Query name:        :$quername"
	echo "--------------------------------------------------"
	start=$(date +%s)
	
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	echo "<<< Load ${filename} in ${1} collection."
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	###
	# Load data in temporary collection.
	###
	arangoimport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--file "${epoc}/${span}/${filename}.csv.gz" \
		--type "csv" \
		--translate "${headname}=value" \
		--collection "$1" \
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
	echo ">>> Process and dump ${filename} to file."
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	###
	# Load data in temporary collection.
	###
	arangoexport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--output-directory "$expo" \
		--custom-query-file "${path}/RemoteSensing/queries/${quername}" \
		--custom-query-bindvars "{\"@@collection\": \"${1}\", \"variable\": \"${variable}\"}" \
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

	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> Move ${variable} to JSONL directory."
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	###
	# Move file to its directory.
	###
	mv -f "${expo}/query.jsonl.gz" "${path}/RemoteSensing/JSONL/${variable}.jsonl.gz"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	echo "<<< Load ${variable} in ${2} collection."
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	###
	# Load data in merge collection.
	###
	if [ $first -eq 1 ]
	then
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "${path}/RemoteSensing/JSONL/${variable}.jsonl.gz" \
			--type "jsonl" \
			--collection "$2" \
			--auto-rate-limit true \
			--overwrite
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
		first=0
	else
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "${path}/RemoteSensing/JSONL/${variable}.jsonl.gz" \
			--type "jsonl" \
			--collection "$2" \
			--auto-rate-limit true
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	fi

	end=$(date +%s)
	elapsed=$((end-start))
	echo "--------------------------------------------------"
	echo "- ${variable} completed in: $elapsed seconds"
	echo "--------------------------------------------------"
	echo ""
   
done < "$3"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>> Merge yearly data and dump ${span}."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
###
# Load data in temporary collection.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${path}/RemoteSensing/queries/merge.aql" \
	--custom-query-bindvars "{\"@@collection\": \"${2}\"}" \
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

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>> Move ${span}.jsonl.gz to DATA directory."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
###
# Move file to its directory.
###
mv -f "${expo}/query.jsonl.gz" "${path}/RemoteSensing/data/${span}.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

process_yearly_data_end=$(date +%s)
elapsed=$((process_yearly_data_end-process_yearly_data_start))
echo "=================================================="
echo "= process_yearly_data.sh duration: $elapsed seconds"
echo "=================================================="
echo ""
