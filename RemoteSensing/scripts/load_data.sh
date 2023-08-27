#!/bin/sh

###
# Load remote sensing data into the GeoService database.
#
# Parameters:
# - $1: Database name.
# - $2: Collection name.
#
# Note that this script expects the geo service database to be on-line,
# the script will load yearly, monthly and daily data, from the dumps
# in the data directory, into the provided database and collection.
# The contents of the collection will be cleared.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= load_data.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
load_data_start=$(date +%s)

###
# Set path parameters.
###
epoc="${path}/RemoteSensing/CSV"

###
# Iterate period spans.
###
first=1
for span in "std_date_span_year" "std_date_span_month" "std_date_span_day"
do

	echo "--------------------------------------------------"
	echo "- Loading:"
	echo "  - Database:   $1"
	echo "  - Collection: $2"
	echo "  - File:       $span"
	echo "--------------------------------------------------"
	start=$(date +%s)
	
	###
	# Load data in final collection.
	###
	if [ $first -eq 1 ]
	then
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$1" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "${path}/RemoteSensing/data/${span}.jsonl.gz" \
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
			--server.database "$1" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "${path}/RemoteSensing/data/${span}.jsonl.gz" \
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
	echo "- ${span} completed in: $elapsed seconds"
	echo "--------------------------------------------------"
	echo ""

done

load_data_end=$(date +%s)
elapsed=$((load_data_end-load_data_start))
echo "=================================================="
echo "= load_data.sh duration: $elapsed seconds"
echo "=================================================="
echo ""
