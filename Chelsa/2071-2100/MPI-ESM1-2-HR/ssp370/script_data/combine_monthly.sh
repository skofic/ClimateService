#!/bin/sh

###
# Combine all monthly processed files into collection temp_pong.
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
# Iterate processed files.
###

echo "====================================================================="
echo "= Stack files into temp_pong"
echo "====================================================================="
first=1
for name in "pr" "tas" "tasmax" "tasmin"
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
		if [ $first -eq 1 ]
		then
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$user" \
				--server.password "$pass" \
				--file "$epoc/data/$name/${name}_${month}.csv.gz" \
				--type "csv" \
				--collection "temp_pong" \
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
		else
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$user" \
				--server.password "$pass" \
				--file "$epoc/data/$name/${name}_${month}.csv.gz" \
				--type "csv" \
				--collection "temp_pong" \
				--auto-rate-limit true \
				--ignore-missing
			if [ $? -ne 0 ]
			then
				echo "*************"
				echo "*** ERROR ***"
				echo "*************"
				exit 1
			fi
		fi
		first=0
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
	done
	
done
