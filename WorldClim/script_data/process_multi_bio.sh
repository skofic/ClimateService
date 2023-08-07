#!/bin/sh

###
# Process annual files, set variable, scale and offset.
# Multiple bands version.
#
# The script expects the following parameters:
# - $1: Full file path of dump to import.
# - $2: Full file path of processed CSV data.
# - $3: Import/export collection name.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
head="${path}/WorldClim/config/header_bio.csv"
query="${path}/WorldClim/script_query/process_multi_bio.aql"

###
# Import file into database.
# Translate variable names to descriptor names.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$1" \
	--headers-file "$head" \
	--type "csv" \
	--collection "$3" \
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
# Scale bio04 value and set descriptor names.
###
arangoexport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--output-directory "$expo" \
	--custom-query-file "$query" \
	--custom-query-bindvars "{\"@@collection\": \"$3\"}" \
	--fields "lon","lat","bio01","bio02","bio03","bio04","bio05","bio06","bio07","bio08","bio09","bio10","bio11","bio12","bio13","bio14","bio15","bio16","bio17","bio18","bio19" \
	--translate "bio01=${pref}_bio01" \
	--translate "bio02=${pref}_bio02" \
	--translate "bio03=${pref}_bio03" \
	--translate "bio04=${pref}_bio04" \
	--translate "bio05=${pref}_bio05" \
	--translate "bio06=${pref}_bio06" \
	--translate "bio07=${pref}_bio07" \
	--translate "bio08=${pref}_bio08" \
	--translate "bio09=${pref}_bio09" \
	--translate "bio10=${pref}_bio10" \
	--translate "bio11=${pref}_bio11" \
	--translate "bio12=${pref}_bio12" \
	--translate "bio13=${pref}_bio13" \
	--translate "bio14=${pref}_bio14" \
	--translate "bio15=${pref}_bio15" \
	--translate "bio16=${pref}_bio16" \
	--translate "bio17=${pref}_bio17" \
	--translate "bio18=${pref}_bio18" \
	--translate "bio19=${pref}_bio19" \
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
mv -f "${expo}query.csv.gz" "$2"	
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
