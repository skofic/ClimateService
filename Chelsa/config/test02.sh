#!/bin/sh

###
# Combine all 1981-2010 monthly processed files into collection temp_pong.
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
# Iterate processed files.
###

echo "====================================================================="
echo "= Stack files into temp_pong"
echo "====================================================================="
first=1
for name in "pr"
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