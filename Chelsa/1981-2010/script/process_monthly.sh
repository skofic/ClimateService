#!/bin/sh

###
# Process all 1981-2010 monthly variables.
# Will iterate all monthly data files,
# eventually normalising the value
# adding the month number,
# and generating a compressed CSV file
# moving it in its directory.
###

###
# Globals.
###
path="/usr/local/Chelsa/1981-2010"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

###
# Iterate monthly precipitation,
# divide value by 100.
###
for name in "pr"
do

	###
	# Iterate months.
	###
	echo "====================================================================="
	echo "= $name"
	echo "====================================================================="
 	for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
	do
		echo "==> $name_$month"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${name}_${month}.csv" \
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
			--custom-query "FOR doc IN temp_ping FILTER doc.value != 0 RETURN {lon: doc.lon, lat: doc.lat, std_month: TO_NUMBER(\"${month}\"), env_${name}: doc.value * 0.01}" \
			--fields "lon","lat","std_month","env_${name}" \
			--compress-output true \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${name}_${month}.csv.gz"
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done

###
# Iterate monthly temperature.
###
for name in "tas" "tasmax" "tasmin"
do

	###
	# Iterate months.
	###
	echo "====================================================================="
	echo "= $name"
	echo "====================================================================="
	for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
	do
		echo "==> $name_$month"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$path/CSV/$name/${name}_${month}.csv" \
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
			--custom-query "FOR doc IN temp_ping FILTER doc.value != 0 RETURN { lon: doc.lon, lat: doc.lat, std_month: TO_NUMBER(\"${month}\"), env_${name}: doc.value * 0.1 }" \
			--fields "lon","lat","std_month","env_${name}" \
			--compress-output true \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${path}/data/$name/${name}_${month}.csv.gz"
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
