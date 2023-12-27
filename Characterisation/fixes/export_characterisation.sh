#!/bin/sh

###
# EXPORT characterisation data and datasets.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Parameters.
###
query_data="${path}/Characterisation/fixes/export_data.aql"
query_dataset="${path}/Characterisation/fixes/export_dataset.aql"

###
# Export data.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "EUFGIS" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query_data" \
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
# Move data to its directory.
###
mv -f "${expo}/query.jsonl.gz" "${expo}/data.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Export dataset.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "EUFGIS" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query_dataset" \
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
# Move data to its directory.
###
mv -f "${expo}/query.jsonl.gz" "${expo}/dataset.jsonl.gz"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
