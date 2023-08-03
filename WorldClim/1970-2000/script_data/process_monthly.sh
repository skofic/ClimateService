#!/bin/sh

###
# Process all monthly variables.
#
# Will iterate all monthly data files,
# normalising the value according to Chelsa instructions
# and generating a compressed CSV file
# moving it in its directory.
#
# This is the second step in the PROCESS workflow.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Process monthly data."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
epoc="$path/WorldClim/1970-2000"
cmd="${path}/WorldClim/script_data/process_monthly.sh"

###
# Iterate monthly data files.
###
for name in "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
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
		# Process variable name and scale to 0.01.
		###
		$cmd "${epoc}/CSV/${name}/${name}_${month}.csv.gz" \
			 "${epoc}/data/${name}/${name}_${month}.csv.gz" \
			 "${path}/WorldClim/script_query/process.aql" \
			 "{\"@@collection\": \"$coll\", \"variable\": \"${pref}_${name}\", \"month\": \"$month\"}" \
			 "$coll" \
			 "${pref}_${name}"
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
