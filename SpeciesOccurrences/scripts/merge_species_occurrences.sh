#!/bin/sh

###
# Merge species occurrences.
#
# This script will merge all species occurrences
# into species_occurrences.jsonl.gz in the data dicerctory.
###

source "${HOME}/.ClimateService"

###
# Iterate occurrence files.
###
first=1
while read -r name
do
	
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	echo "<<< Load ${name} into temp_ping."
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	arangoimport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--file "${path}/SpeciesOccurrences/EU-Trees4F/species_occurrences/${name}.csv" \
		--type "csv" \
		--collection "temp_ping" \
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
	echo ">>> Process ${name} data and dump."
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	arangoexport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--output-directory "$expo" \
		--custom-query-file "${path}/SpeciesOccurrences/queries/stack_occurrences.aql" \
		--custom-query-bindvars "{\"@@collection\": \"temp_ping\", \"species\": \"${name}\"}" \
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
	echo "<<< Stack processed ${name} data into temp_occurrences."
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	if [ $first -eq 1 ]
	then
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "${expo}/query.jsonl.gz" \
			--type "jsonl" \
			--collection "temp_occurrences" \
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
			--file "${expo}/query.jsonl.gz" \
			--type "jsonl" \
			--collection "temp_occurrences" \
			--auto-rate-limit true
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	fi
	
done < "${path}/SpeciesOccurrences/EU-Trees4F/species_list.txt"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>> Merge stacked data into dump file."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${path}/SpeciesOccurrences/queries/merge_occurrences.aql" \
	--custom-query-bindvars "{\"@@collection\": \"temp_occurrences\"}" \
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
echo ">>> Move dump file to DATA directory."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
mkdir -p "${path}/SpeciesOccurrences/data"
###
# Move file to its directory.
###
mv -f "${expo}/query.jsonl.gz" "${path}/SpeciesOccurrences/data/occurrences.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
echo "<<< Load occurrences into occurrences."
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
arangoimport \
	--server.endpoint "$host" \
	--server.database "GeoService" \
	--server.username "$user" \
	--server.password "$pass" \
	--collection "SpeciesOccurrences" \
	--file "${path}/SpeciesOccurrences/data/occurrences.jsonl.gz" \
	--type "jsonl" \
	--auto-rate-limit true \
	--overwrite
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
