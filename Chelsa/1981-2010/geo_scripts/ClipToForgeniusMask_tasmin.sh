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
name="tasmin"
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"
full="${path}/Chelsa/1981-2010/Full/$name"
clip="${path}/Chelsa/1981-2010/ForgeniusClipped/$name"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip monthly mean daily minimum ERA5 2m. air temperature global TIFF to Forgenius region.
###
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_01.tif" "$clip/tasmin_01.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_02.tif" "$clip/tasmin_02.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_03.tif" "$clip/tasmin_03.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_04.tif" "$clip/tasmin_04.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_05.tif" "$clip/tasmin_05.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_06.tif" "$clip/tasmin_06.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_07.tif" "$clip/tasmin_07.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_08.tif" "$clip/tasmin_08.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_09.tif" "$clip/tasmin_09.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_10.tif" "$clip/tasmin_10.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_11.tif" "$clip/tasmin_11.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/tasmin_12.tif" "$clip/tasmin_12.tif"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
