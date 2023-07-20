#!/bin/sh

###
# Clip maps to EUFGIS region.
###

###
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

###
# Globals.
###
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"

echo "=================================================="
echo "= CLIP FILES"
echo "=================================================="
start=$(date +%s)

###
# Clip bio.
###
name="bio"
full="${path}/Chelsa/1981-2010/Full/$name"
clip="${path}/Chelsa/1981-2010/ForgeniusClipped/$name"

###
# Clip bioclimatic variables global TIFF to Forgenius region.
###

echo "--------------------------------------------------"
echo "$name"
echo "--------------------------------------------------"

for var in "ai" "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "clt_max" "clt_max" "clt_mean" "clt_min" "clt_range" "cmi_max" "cmi_mean" "cmi_min" "cmi_range" "gdd0" "gdd5" "gdd10" "gsp" "gst" "hurs_max" "hurs_mean" "hurs_min" "hurs_range" "npp" "pet_penman_max" "pet_penman_mean" "pet_penman_min" "pet_penman_range" "rsds_max" "rsds_mean" "rsds_min" "rsds_range" "sfcWind_max" "sfcWind_mean" "sfcWind_min" "sfcWind_range" "swb" "swe" "vpd_max" "vpd_mean" "vpd_min" "vpd_range"
do
	gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/$var.tif" "$clip/$var.tif"
done

###
# Clip integer point variables.
###
for var in "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd5" "ngd10" "scd"
do
	gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/${var}.tif" "$clip/${var}.tif"
done

###
# Clip monthly.
###
for name in "pr" "tas" "tasmax" "tasmin"
do

	echo "--------------------------------------------------"
	echo "$name"
	echo "--------------------------------------------------"

	###
	# Clip files.
	###
	full="${path}/Chelsa/1981-2010/Full/$name"
	clip="${path}/Chelsa/1981-2010/ForgeniusClipped/$name"
	for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
	do
		gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/${name}_${month}.tif" "$clip/${name}_${month}.tif"
	done

done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= CLIP FILES: $elapsed seconds"
echo "=================================================="
echo ""
