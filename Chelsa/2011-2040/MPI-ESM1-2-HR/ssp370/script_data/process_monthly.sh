#!/bin/sh

###
# Process all monthly variables.
#
# Will iterate all monthly data files,
# normalising the value according to Chelsa instructions
# and generating a compressed CSV file
# moving it in its directory.
#
# This is the first step in the PREPARE workflow.
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
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
cmd="${path}/Chelsa/script_data/process_monthly.sh"

# ###
# # Iterate monthly precipitation,
# # divide value by 100.
# ###
# for name in "pr"
# do
# 
# 	###
# 	# Iterate months.
# 	###
# 	echo "====================================================================="
# 	echo "= $name"
# 	echo "====================================================================="
#  	for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
# 	do
# 		echo "==> $name_$month"
# 		start=$(date +%s)
# 	
# 		###
# 		# Process variable name and scale to 0.01.
# 		###
# 		$cmd "${epoc}/CSV/${name}/${name}_${month}.csv.gz" \
# 			 "${epoc}/data/${name}/${name}_${month}.csv.gz" \
# 			 "${path}/Chelsa/script_query/process_scale001_month.aql" \
# 			 "{\"@@collection\": \"$coll\", \"variable\": \"${pref}_${name}\", \"month\": \"$month\"}" \
# 			 "$coll" \
# 			 "${pref}_${name}"
# 		if [ $? -ne 0 ]
# 		then
# 			echo "*************"
# 			echo "*** ERROR ***"
# 			echo "*************"
# 			exit 1
# 		fi
# 		
# 		end=$(date +%s)
# 		elapsed=$((end-start))
# 		echo "--------------------------------------------------"
# 		echo "2011-2040 process_monthly.sh (${name}_${month} scale 0.01)"
# 		echo "Elapsed time: $elapsed seconds"
# 		echo "----------------------------------------"
# 	done
# 	
# done

###
# Iterate monthly temperature.
###
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
		# Process variable name and scale to 0.1.
		###
		$cmd "${epoc}/CSV/${name}/${name}_${month}.csv.gz" \
			 "${epoc}/data/${name}/${name}_${month}.csv.gz" \
			 "${path}/Chelsa/script_query/process_scale01_month.aql" \
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
		echo "--------------------------------------------------"
		echo "2011-2040 process_monthly.sh (${name}_${month} scale 0.1)"
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"
	done
	
done
