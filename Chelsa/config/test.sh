#!/bin/sh

###
# Clip maps to useful region.
###

###
# Parameters.
###
read arg
user="$arg"
read arg
pass="$arg"
read arg
path="$arg"

###
# Globals.
###
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"
full="${path}/Chelsa/1981-2010/Full/bio"
clip="${path}/Chelsa/1981-2010/ForgeniusClipped/bio"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip bioclimatic variables global TIFF to Forgenius region.
###
echo "Polygon: $poly"
echo "Full:    $full"
echo "Clip:    $clip"
# gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/ai.tif" "$clip/ai.tif"
# gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/bio01.tif" "$clip/bio01.tif"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
