#!/bin/sh

###
# Process all annual variables.
#
# Will iterate all annual data files,
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
echo "= Process annual data."
echo "====================================================================="

###
# Globals.
###
coll="temp_ping"
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
cmd="${path}/Chelsa/script_data/process_annual.sh"

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
 	for variable in "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "lgd" "ngd0" "ngd5" "ngd10" "scd"
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
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg0, kg1, kg2."
	echo "====================================================================="
  	for variable in "kg0" "kg1" "kg2"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name and convert to string.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/koppen_geiger_0_1_2.aql" \
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
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg3."
	echo "====================================================================="
  	for variable in "kg3"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name and convert to string.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/koppen_geiger_3.aql" \
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
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg4."
	echo "====================================================================="
  	for variable in "kg4"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name and convert to string.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/koppen_geiger_4.aql" \
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
	# Handle no scale and no offset and convert to string.
	###
	echo ""
	echo "====================================================================="
	echo "= kg5."
	echo "====================================================================="
  	for variable in "kg5"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name and convert to string.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/koppen_geiger_5.aql" \
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
	# Handle scale to 0.1.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.1."
	echo "====================================================================="
  	for variable in "bio02" "bio03" "bio07" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "gdd0" "gdd5" "gdd10" "gsp" "npp" "swe"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name and convert to scale 0.1.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/process_scale01.aql" \
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
	# Handle scale to 0.001.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.001."
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
			 "${path}/Chelsa/script_query/process_scale0001.aql" \
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
	# Handle scale to 0.1 and offset to -273.15.
	###
	echo ""
	echo "====================================================================="
	echo "= Scale 0.1 Offset -273.15."
	echo "====================================================================="
  	for variable in "bio01" "bio05" "bio06" "bio08" "bio09" "bio10" "bio11" "gst"
	do
		echo "==> $variable"
		start=$(date +%s)
	
		###
		# Process variable name, convert to scale 0.1 and offset -273.15.
		###
		$cmd "${epoc}/CSV/${name}/${variable}.csv.gz" \
			 "${epoc}/data/${name}/${variable}.csv.gz" \
			 "${path}/Chelsa/script_query/process_scale01_offset27315.aql" \
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
