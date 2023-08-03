#!/bin/sh

###
# Process all annual variables.
#
# The script will process all annual CSV files by:
# - loading the data into the database,
# - setting the value variable name to the correct descriptor name,
# - performing eventual scaling and offsets,
# - and exporting the result to a dump file.
#
# This is the first step in the PROCESS workflow.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Process annual data."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
epoc="$path/WorldClim/1970-2000"
cmd="${path}/WorldClim/script_data/process_annual.sh"

###
# Iterate monthly file base names.
###
for name in "bio"
do

	echo "*********************************************************************"
	echo "* $name"
	echo "*********************************************************************"

	###
	# Handle no scale or offset.
	###
	echo ""
	echo "====================================================================="
	echo "= No scale and no offset."
	echo "====================================================================="
 	for variable in "bio01" "bio02" "bio03" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/process.aql" \
			 "{\"@@collection\": \"$coll\", \"variable\": \"${pref}_${variable}\"}" \
			 "$coll" \
			 "${pref}_${variable}"
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

	###
	# Handle scale to 0.01.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.01."
	echo "====================================================================="
  	for variable in "bio04"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name and convert to scale 0.01.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/process_scale001.aql" \
			 "{\"@@collection\": \"$coll\", \"variable\": \"${pref}_${variable}\"}" \
			 "$coll" \
			 "${pref}_${variable}"
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
