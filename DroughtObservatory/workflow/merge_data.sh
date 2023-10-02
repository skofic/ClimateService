#!/bin/sh

###
# Merge data into GeoService collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="GeoService"
collection="DroughtObservatory"
epoc="${path}/DroughtObservatory"

echo "=================================================="
echo "= MERGE DATA FILES"
echo "=================================================="
start=$(date +%s)

###
# Launch jobs sequentially.
###
first=1
for area in "1km" "5km" "25km"
do
	
	###
	# Set dump file path.
	###
	dump="${epoc}/data/GDO_data_${area}.jsonl.gz"

	echo ""
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> IMPORT GDO_data_${area}.jsonl.gz"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	
	###
	# Import file into database.
	###
	if [ $first -eq 1 ]
	then
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$dump" \
			--type "jsonl" \
			--collection "$collection" \
			--auto-rate-limit true \
			--overwrite true
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
			--auto-rate-limit true \
			--overwrite false
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	fi
	
	first=0

done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= MERGE DATA FILES: $elapsed seconds"
echo "=================================================="
echo ""
