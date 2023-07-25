#!/bin/sh

###
# Clip maps to useful region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"

###
# Parameters.
###
name="bio"
epoc="$path/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
full="${epoc}/Full/${name}"
clip="${epoc}/ForgeniusClipped/${name}"

###
# Clip bioclimatic variables global TIFF to Forgenius region.
###
echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip floating point variables.
###
for var in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "gdd0" "gdd5" "gdd10" "gsp" "gst" "npp" "swe"
do
	gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/$var.tif" "$clip/$var.tif"
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
for var in "fcf" "fgd" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd5" "ngd10" "scd"
do
	gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/${var}.tif" "$clip/${var}.tif"
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
