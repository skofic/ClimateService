#!/bin/sh

###
# Clip bioclimatic maps to region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip bioclimatic variables to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
name="bio"
epoc="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
full="${epoc}/Full/${name}"
clip="${epoc}/Clipped/${name}"

###
# Clip bioclimatic variables global TIFF to region.
###
echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Clip floating point variables.
###
cmd="${path}/Chelsa/script_geo/clip_float32.sh"
for var in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "gdd0" "gdd5" "gdd10" "gsp" "gst" "npp" "swe"
do
	$cmd "${full}/${var}.tif" "${clip}/${var}.tif" "$poly" "$pnam"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

###
# Clip integer point variables.
###
cmd="${path}/Chelsa/script_geo/clip_uint16.sh"
for var in "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd5" "ngd10" "scd"
do
	$cmd "${full}/${var}.tif" "${clip}/${var}.tif" "$poly" "$pnam"
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
echo "2071-2100 clip_bio.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
