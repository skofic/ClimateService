#!/bin/sh

###
# Clip bioclimatic maps to EUFGIS region.
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
epoc="${path}/Chelsa/1981-2010"

###
# Parameters.
###
full="${epoc}/Full/${name}"
clip="${epoc}/ForgeniusClipped/${name}"

###
# Clip bioclimatic variables global TIFF to Forgenius region.
###
echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Clip Float32 variables.
###
cmd="${path}/Chelsa/script_geo/clip_float32.sh"
for var in "ai" "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "clt_max" "clt_mean" "clt_min" "clt_range" "cmi_max" "cmi_mean" "cmi_min" "cmi_range" "gdd0" "gdd5" "gdd10" "gsp" "gst" "hurs_max" "hurs_mean" "hurs_min" "hurs_range" "npp" "pet_penman_max" "pet_penman_mean" "pet_penman_min" "pet_penman_range" "rsds_max" "rsds_mean" "rsds_min" "rsds_range" "sfcWind_max" "sfcWind_mean" "sfcWind_min" "sfcWind_range" "swb" "swe" "vpd_max" "vpd_mean" "vpd_min" "vpd_range"
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
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
