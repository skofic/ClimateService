#!/bin/sh

###
# Combine all bioclimatic processed files into collection temp_pong.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Stack annual data."
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
epoc="${path}/Chelsa/1981-2010"

###
# Iterate processed files.
###
first=1
cmd="${path}/Chelsa/script_data/combine.sh"
for folder in "bio"
do

	###
	# Iterate variables.
	###
	for name in "ai" "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "clt_max" "clt_mean" "clt_min" "clt_range" "cmi_max" "cmi_mean" "cmi_min" "cmi_range" "fcf" "fgd" "gdd0" "gdd10" "gdd5" "gddlgd0" "gddlgd10" "gddlgd5" "gdgfgd0" "gdgfgd10" "gdgfgd5" "gsl" "gsp" "gst" "hurs_max" "hurs_mean" "hurs_min" "hurs_range" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd10" "ngd5" "npp" "pet_penman_max" "pet_penman_mean" "pet_penman_min" "pet_penman_range" "rsds_max" "rsds_mean" "rsds_min" "rsds_range" "scd" "sfcWind_max" "sfcWind_mean" "sfcWind_min" "sfcWind_range" "swb" "swe" "vpd_max" "vpd_mean" "vpd_min" "vpd_range"
	do

		echo "----------------------------------------"
		echo "==> $name"
		start=$(date +%s)
	
		###
		# Import file into database.
		###
		$cmd "${epoc}/data/${folder}/${name}.csv.gz" \
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
		echo "1981-2010 combine_annual.sh (${name})"
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"

	done

done
