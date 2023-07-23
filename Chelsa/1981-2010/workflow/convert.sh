#!/bin/sh

###
# Convert maps to GeoJSON.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= CONVERT FILES"
echo "=================================================="
start=$(date +%s)

###
# Parameters.
###
name="bio"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/${name}"

echo "--------------------------------------------------"
echo "$name"
echo "--------------------------------------------------"

###
# Convert clipped bioclimatic variables to CSV format.
###
for var in "ai" "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "clt_max" "clt_mean" "clt_min" "clt_range" "cmi_max" "cmi_mean" "cmi_min" "cmi_range" "fcf" "fgd" "gdd0" "gdd10" "gdd5" "gddlgd0" "gddlgd10" "gddlgd5" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "gsp" "gst" "hurs_max" "hurs_mean" "hurs_min" "hurs_range" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd10" "ngd5" "npp" "pet_penman_max" "pet_penman_mean" "pet_penman_min" "pet_penman_range" "rsds_max" "rsds_mean" "rsds_min" "rsds_range" "scd" "sfcWind_max" "sfcWind_mean" "sfcWind_min" "sfcWind_range" "swb" "swe" "vpd_max" "vpd_mean" "vpd_min" "vpd_range"
do
	echo "==> $var"
	gdal2xyz.py -skipnodata -csv "$from/$var.tif" "$dest/$var.csv"
done

###
# Convert clipped monthly variables to CSV format.
###
for name in "pr" "tas" "tasmax" "tasmin"
do
	echo "--------------------------------------------------"
	echo "$name"
	echo "--------------------------------------------------"

	###
	# Parameters.
	###
	from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
	dest="${path}/Chelsa/1981-2010/CSV/${name}"

	###
	# Iterate months.
	###
	for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
	do
		gdal2xyz.py -skipnodata -csv "$from/${name}_${month}.tif" "$dest/${name}_${month}.csv"
	done
done

end=$(date +%s)

elapsed=$((end-start))
echo "=================================================="
echo "= CONVERT FILES: $elapsed seconds"
echo "=================================================="
echo ""
