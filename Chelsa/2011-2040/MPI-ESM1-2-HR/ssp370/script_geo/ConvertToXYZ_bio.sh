#!/bin/sh

###
# Convert bioclimatic maps to CSV.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Convert bioclimatic variables to CSV."
echo "====================================================================="

###
# Globals.
###
name="bio"
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
from="${epoc}/ForgeniusClipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Convert clipped bioclimatic variables to CSV format.
###
cmd="${path}/Chelsa/script_geo/convert.sh"
for var in "ai" "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "clt_max" "clt_mean" "clt_min" "clt_range" "cmi_max" "cmi_mean" "cmi_min" "cmi_range" "fcf" "fgd" "gdd0" "gdd10" "gdd5" "gddlgd0" "gddlgd10" "gddlgd5" "gdgfgd0" "gdgfgd10" "gdgfgd5" "gsl" "gsp" "gst" "hurs_max" "hurs_mean" "hurs_min" "hurs_range" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd10" "ngd5" "npp" "pet_penman_max" "pet_penman_mean" "pet_penman_min" "pet_penman_range" "rsds_max" "rsds_mean" "rsds_min" "rsds_range" "scd" "sfcWind_max" "sfcWind_mean" "sfcWind_min" "sfcWind_range" "swb" "swe" "vpd_max" "vpd_mean" "vpd_min" "vpd_range"
do

	###
	# Convert to CSV and gzip.
	###
	$cmd "${from}/${var}.tif" "${dest}/${var}.csv"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
