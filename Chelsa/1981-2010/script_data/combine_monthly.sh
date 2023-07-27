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
coll="temp_pong"
epoc="${path}/Chelsa/1981-2010"

echo "====================================================================="
echo "= Stack annual data into temp_pong"
echo "====================================================================="

###
# Iterate processed files.
###
first=1
cmd="${path}/Chelsa/script_data/combine.sh"
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
		echo "==> ${name}_${month}"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		$cmd "${epoc}/data/${name}/${name}_${month}.csv.gz" \
			 "$coll" \
			 $first
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
		
		first=0
		
		end=$(date +%s)
		elapsed=$((end-start))
		echo "Elapsed time: ${elapsed} seconds"
	done
	
done
