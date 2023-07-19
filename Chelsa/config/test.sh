#!/bin/sh

###
# Process all 1981-2010 bioclimatic variables.
# Will iterate all bioclimatic data files,
# normalising the value according to Chelsa instructions
# and generating a compressed CSV file
# moving it in its directory.
###

###
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

###
# Globals.
###
base="Climate"
epoc="$path/Chelsa/1981-2010"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

name="kg0"
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$epoc/CSV/$name/${variable}.csv.gz" \
	--headers-file "$head" \
	--type "csv" \
	--collection "temp_ping" \
	--ignore-missing \
	--overwrite


# ###
# # Iterate monthly file base names.
# ###
# for name in "bio"
# do
# 
# 	echo "*********************************************************************"
# 	echo "* $name"
# 	echo "*********************************************************************"
# 
# 	###
# 	# Handle no scale and no offset and convert to string.
# 	###
# 	echo ""
# 	echo "====================================================================="
# 	echo "= No scale and no offset and convert to string."
# 	echo "====================================================================="
#   	for variable in "kg0" "kg1" "kg2" "kg3" "kg4" "kg5"
# 	do
# 		echo "==> $variable"
# 		start=$(date +%s)
# 	
# 		###
# 		# Import file into database.
# 		###
# 		arangoimport \
# 			--server.endpoint "$host" \
# 			--server.database "$base" \
# 			--server.username "$user" \
# 			--server.password "$pass" \
# 			--file "$epoc/CSV/$name/${variable}.csv.gz" \
# 			--headers-file "$head" \
# 			--type "csv" \
# 			--collection "temp_ping" \
# 			--ignore-missing \
# 			--overwrite
# 		
# 		###
# 		# Export data to CSV file.
# 		###
# 		arangoexport \
# 			--server.endpoint "$host" \
# 			--server.database "$base" \
# 			--server.username "$user" \
# 			--server.password "$pass" \
# 			--output-directory "$expo" \
# 			--overwrite true \
# 			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, env_${variable}: CONCAT_SEPARATOR(\"_\", \"env_${variable}\", TO_STRING(doc.value))}" \
# 			--compress-output true \
# 			--fields "lon","lat","env_${variable}" \
# 			--type "csv"
# 		
# 		###
# 		# Move file to its directory.
# 		###
# 		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
# 		
# 		end=$(date +%s)
# 		elapsed=$((end-start))
# 		echo "Elapsed time: $elapsed seconds"
# 		echo "----------------------------------------"
# 	done
# 	
# done
