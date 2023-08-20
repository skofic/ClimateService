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
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
from="${epoc}/Clipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Convert clipped bioclimatic variables to CSV format.
###
cmd="${path}/Chelsa/script_geo/convert.sh"
for var in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "gdd0" "gdd5" "gdd10" "gsp" "gst" "npp" "swe" "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd5" "ngd10" "scd"
do

	###
	# Convert to CSV and gzip.
	###
	echo "=> ${var}"
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
echo "--------------------------------------------------"
echo "2041-2070 convert_bio.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
