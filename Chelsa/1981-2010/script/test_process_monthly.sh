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
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="Climate"
epoc="$path/Chelsa/1981-2010"
head="$path/Chelsa/config/header.csv"
expo="$path/exports/"

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
 	for month in "01" "02"
		echo "==> $name_$month"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${name}_${month}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--auto-rate-limit true \
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
			--custom-query "FOR doc IN temp_ping FILTER doc.value != 0 RETURN {lon: doc.lon, lat: doc.lat, std_month: TO_NUMBER(\"${month}\"), ${pref}_${name}: doc.value * 0.01}" \
			--fields "lon","lat","std_month","${pref}_${name}" \
			--compress-output true \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${name}_${month}.csv.gz"
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done

###
# Iterate monthly temperature.
###
for name in "tas"
do

	###
	# Iterate months.
	###
	echo "====================================================================="
	echo "= $name"
	echo "====================================================================="
	for month in "01" "02"
	do
		echo "==> $name_$month"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${name}_${month}.csv" \
			--headers-file "$head" \
			--type "csv" \
			--collection "temp_ping" \
			--auto-rate-limit true \
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
			--custom-query "FOR doc IN temp_ping FILTER doc.value != 0 RETURN { lon: doc.lon, lat: doc.lat, std_month: TO_NUMBER(\"${month}\"), ${pref}_${name}: doc.value * 0.1 }" \
			--fields "lon","lat","std_month","${pref}_${name}" \
			--compress-output true \
			--type "csv"
		
		###
		# Move file to its directory.
		###
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${name}_${month}.csv.gz"
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
