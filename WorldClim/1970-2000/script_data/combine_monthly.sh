#!/bin/sh

###
# Combine all monthly processed files into collection temp_pong.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Stack monthly data."
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
epoc="${path}/WorldClim/1970-2000"

###
# Iterate processed files.
###
first=1
cmd="${path}/WorldClim/script_data/combine.sh"
for name in "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
do

	###
	# Iterate months.
	###
	for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
	do
		echo "----------------------------------------"
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
		echo "--------------------------------------------------"
		echo "1970-2000 combine_monthly.sh (${name}_${month})"
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
