#!/bin/sh

###
# Process all bioclimatic variables.
#
# Will iterate all bioclimatic data files,
# normalising the value according to Chelsa instructions
# and generating a compressed CSV file
# moving it in its directory.
#
# This is the first step in the PREPARE workflow.
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
 	for variable in "ai" "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "lgd" "ngd0" "ngd5" "ngd10" "scd"
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
  	for variable in "kg0" "kg1" "kg2"
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
  	for variable in "bio02" "bio03" "bio07" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "cmi_max" "cmi_mean" "cmi_min" "cmi_range" "gdd0" "gdd5" "gdd10" "gsp" "npp" "swb" "swe" "vpd_max" "vpd_mean" "vpd_min" "vpd_range"
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
  	for variable in "clt_max" "clt_mean" "clt_min" "clt_range" "hurs_max" "hurs_mean" "hurs_min" "hurs_range" "pet_penman_max" "pet_penman_mean" "pet_penman_min" "pet_penman_range"
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
  	for variable in "bio04" "rsds_max" "rsds_mean" "rsds_min" "rsds_range" "sfcWind_max" "sfcWind_mean" "sfcWind_min" "sfcWind_range"
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
  	for variable in "bio1" "bio5" "bio6" "bio8" "bio9" "bio10" "bio11" "gst"
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
