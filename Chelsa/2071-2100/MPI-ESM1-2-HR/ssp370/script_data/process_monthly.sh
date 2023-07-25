#!/bin/sh

###
# Process all monthly variables.
#
# Will iterate all monthly data files,
# eventually normalising the value
# adding the month number,
# and generating a compressed CSV file
# moving it in its directory.
#
# This is the first step in the PREPARE workflow.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
base="Climate"
expo="$path/exports/"
head="$path/Chelsa/config/header.csv"
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"

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
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${name}_${month}.csv.gz" \
			--headers-file "$head" \
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
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${name}_${month}.csv.gz"
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
		
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
			--server.username "$user" \
			--server.password "$pass" \
			--file "$epoc/CSV/$name/${name}_${month}.csv.gz" \
			--headers-file "$head" \
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
		mv --force "${expo}query.csv.gz" "${epoc}/data/$name/${name}_${month}.csv.gz"
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
