#!/bin/sh

###
# TEST
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
head="$path/Chelsa/config/header.csv"
expo="$path/exports/"

###
# Iterate monthly file base names.
###
for name in "bio"
do

	echo "*********************************************************************"
	echo "* $name"
	echo "*********************************************************************"

	###
	# Handle no scale or offset.
	###
	echo ""
	echo "====================================================================="
	echo "= No scale and no offset."
	echo "====================================================================="
 	for variable in "ai"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, ${pref}_${variable}: doc.value}" \
			--fields "lon","lat","${pref}_${variable}" \
			--compress-output true \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg0, kg1, kg2."
	echo "====================================================================="
  	for variable in "kg0"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query-file "$path/Chelsa/config/koppen_geiger_0_1_2.aql" \
			--custom-query-bindvars "{\"variable\": \"${variable}\", \"prefix\": \"${prefix}\"}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg3."
	echo "====================================================================="
  	for variable in "kg3"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query-file "$path/Chelsa/config/koppen_geiger_3.aql" \
			--custom-query-bindvars "{\"variable\": \"${variable}\", \"prefix\": \"${prefix}\"}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg4."
	echo "====================================================================="
  	for variable in "kg4"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query-file "$path/Chelsa/config/koppen_geiger_4.aql" \
			--custom-query-bindvars "{\"variable\": \"${variable}\", \"prefix\": \"${prefix}\"}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg5."
	echo "====================================================================="
  	for variable in "kg5"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query-file "$path/Chelsa/config/koppen_geiger_5.aql" \
			--custom-query-bindvars "{\"variable\": \"${variable}\", \"prefix\": \"${prefix}\"}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle scale to 0.1.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.1."
	echo "====================================================================="
  	for variable in "bio02"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--ignore-missing \n			--overwrite--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, ${pref}_${variable}: doc.value * 0.1}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle scale to 0.01.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.01."
	echo "====================================================================="
  	for variable in "clt_max"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, ${pref}_${variable}: doc.value * 0.01}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle scale to 0.001.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.001."
	echo "====================================================================="
  	for variable in "bio04"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, ${pref}_${variable}: doc.value * 0.001}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done

	###
	# Handle scale to 0.1 and offset to -273.15.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.1 Offset -273.15."
	echo "====================================================================="
  	for variable in "bio1"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${variable}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--ignore-missing \
			--overwrite
		
		###
		# Export data to CSV file.
		###
		arangoexport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, ${pref}_${variable}: (doc.value * 0.1) - 273.15}" \
			--compress-output true \
			--fields "lon","lat","${pref}_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
