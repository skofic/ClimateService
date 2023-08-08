#!/bin/sh

###
# Process monthly files, set variable, scale and offset.
#
# The script expects the following parameters:
# - $1: Full file path of dump to import.
# - $2: Full file path of export.
# - $3: Full path of export AQL file.
# - $4: Bind variables dictionary.
# - $5: Import collection name.
# - $6: Variable name
#
# This script will first import the raw CSV file into a temporary collection
# then it will export that collection using a query, to process the values
# into a gzipped CSV dump file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
head="${path}/Chelsa/config/header.csv"

###
# Import file into database.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$1" \
	--headers-file "$head" \
	--type "csv" \
	--collection "$5" \
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

###
# Export data to CSV file.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "${3}" \
	--custom-query-bindvars "$4" \
	--fields "lon","lat","std_month","$6" \
	--compress-output true \
	--overwrite true \
	--type "csv"
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
mv -f "${expo}/query.csv.gz" "$2"	
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
