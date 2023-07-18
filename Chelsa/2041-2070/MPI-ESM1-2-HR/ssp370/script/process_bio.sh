#!/bin/sh

###
# Process all 2041-2070 bioclimatic variables.
# Will iterate all bioclimatic data files,
# normalising the value according to Chelsa instructions
# and generating a compressed CSV file
# moving it in its directory.
###

##–#
# Globals.
###
path="/usr/local/Chelsa/2041-2070/MPI-ESM1-2/ssp370"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

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
 	for variable in "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "lgd" "ngd0" "ngd5" "ngd10" "scd"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${variable}.csv.gz" \
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
			--server.username "$1" \
			--server.username "$2" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, env_${variable}: doc.value}" \
			--fields "lon","lat","env_${variable}" \
			--compress-output true \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${variable}.csv.gz"	
		
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
	echo "= No scale and no offset and convert to string."
	echo "====================================================================="
  	for variable in "kg0" "kg1" "kg2" "kg3" "kg4" "kg5"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${variable}.csv.gz" \
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
			--server.username "$1" \
			--server.username "$2" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, env_${variable}: CONCAT_SEPARATOR(\"_\", \"env_${variable}\", TO_STRING(doc.value))}" \
			--compress-output true \
			--fields "lon","lat","env_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${variable}.csv.gz"	
		
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
  	for variable in "bio02" "bio03" "bio07" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "gdd0" "gdd5" "gdd10" "gsp" "npp" "swe"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${variable}.csv.gz" \
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
			--server.username "$1" \
			--server.username "$2" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, env_${variable}: doc.value * 0.1}" \
			--compress-output true \
			--fields "lon","lat","env_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${variable}.csv.gz"	
		
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
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${variable}.csv.gz" \
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
			--server.username "$1" \
			--server.username "$2" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, env_${variable}: doc.value * 0.001}" \
			--compress-output true \
			--fields "lon","lat","env_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${variable}.csv.gz"	
		
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
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${variable}.csv.gz" \
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
			--server.username "$1" \
			--server.username "$2" \
			--output-directory "$expo" \
			--overwrite true \
			--custom-query "FOR doc IN temp_ping RETURN {lon: doc.lon, lat: doc.lat, env_${variable}: (doc.value * 0.1) - 273.15}" \
			--compress-output true \
			--fields "lon","lat","env_${variable}" \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${variable}.csv.gz"	
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
