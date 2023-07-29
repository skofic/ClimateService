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
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

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
	for name in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "fcf" "fgd" "gdd0" "gdd10" "gdd5" "gddlgd0" "gddlgd10" "gddlgd5" "gdgfgd0" "gdgfgd10" "gdgfgd5" "gsl" "gsp" "gst" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd10" "ngd5" "npp" "scd" "swe"
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
		echo "Elapsed time: $elapsed seconds"
		echo "----------------------------------------"

	done

done
