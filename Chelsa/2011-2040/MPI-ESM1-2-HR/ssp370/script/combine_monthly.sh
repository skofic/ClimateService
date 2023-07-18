#!/bin/sh

###
# Combine all 2011-2040 monthly processed files into collection temp_pong.
###

###
# Globals.
###
path="/usr/local/Chelsa/2011-2040/MPI-ESM1-2/ssp370"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

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
				--server.username "$1" \
				--server.username "$2" \
				--file "$path/data/$name/${name}_${month}.csv.gz" \
				--type "csv" \
				--collection "temp_pong" \
				--ignore-missing \
				--overwrite
		else
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$1" \
				--server.username "$2" \
				--file "$path/data/$name/${name}_${month}.csv.gz" \
				--type "csv" \
				--collection "temp_pong" \
				--ignore-missing
		fi
		first=0
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: $elapsed seconds"
	done
	
done
