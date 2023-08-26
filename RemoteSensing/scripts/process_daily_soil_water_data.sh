#!/bin/sh

###
# Process daily soil water data and save in temp_daily collection.
#
# Parameters:
# - $1: Temporary cache collection.
# - $2: Stack data collection
# - $3: Merge data collection.
# - $4: Full path to the yearly data dictionary.
#
# - The script will iterate all single level daily variables.
#   - The script will iterate all daily variable directories:
#     - The script will iterate the directory files:
#       - It will load the CSV file into the $1 collection.
#       - It will process the $1 collection records and dump the results.
#       - Append the dump to the $2 collection.
#   - The script will dump the $2 collection.
#   - Move the dump to the JSONL directory.
#   - Append the dump to the $3 collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
span="std_date_span_day"

echo "=================================================="
echo "= process_daily_soil_water_data.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
process_daily_soil_water_data_start=$(date +%s)

###
# Set path parameters.
###
epoc="${path}/RemoteSensing/CSV"

###
# Iterate daily single level variables.
###
first=0
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    folder=$(echo $line | cut -d ' ' -f 1)
    variable=$(echo $line | cut -d ' ' -f 2)
    headname=$(echo $line | cut -d ' ' -f 3)
    quername=$(echo $line | cut -d ' ' -f 4)
    
	echo "--------------------------------------------------"
	echo "- Processing:"
	echo "  - Folder name:       :$folder"
	echo "  - Variable name:     :$variable"
	echo "  - Header value name: :$headname"
	echo "  - Query name:        :$quername"
	echo "--------------------------------------------------"
	start=$(date +%s)
	
	###
	#  Iterate folder folders.
	###
	first_file=1
	for item in "${epoc}/${span}/soil_water/${folder}/"*.csv.gz
	do
	
		filename="$(basename ${item})"
		echo ""
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
			--file "$item" \
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
		echo ">>> Process and dump ${filename} to query.jsonl.gz."
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
	
		echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
		echo "<<< Load query.jsonl.gz in ${2} collection."
		echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
		###
		# Load data in stack collection.
		###
		if [ $first_file -eq 1 ]
		then
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$user" \
				--server.password "$pass" \
				--file "${expo}/query.jsonl.gz" \
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
			first_file=0
		else
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$user" \
				--server.password "$pass" \
				--file "${expo}/query.jsonl.gz" \
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
	
	done
	
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> Dump ${variable} to file."
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	###
	# Load data in temporary collection.
	###
	arangoexport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--custom-query-file "${path}/RemoteSensing/queries/no_keys.aql" \
		--custom-query-bindvars "{\"@@collection\": \"${2}\"}" \
		--output-directory "$expo" \
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
	echo "<<< Load ${variable} in ${3} collection."
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	###
	# Load data in stack collection.
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
			--collection "$3" \
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
			--collection "$3" \
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
   
done < "$4"

process_daily_soil_water_data_end=$(date +%s)
elapsed=$((process_daily_soil_water_data_end-process_daily_soil_water_data_start))
echo "=================================================="
echo "= process_daily_soil_water_data.sh duration: $elapsed seconds"
echo "=================================================="
echo ""
