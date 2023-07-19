#!/bin/sh

###
# Download and clip maps.
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
clip="${path}/Chelsa/1981-2010/ForgeniusClipped/name"

###
# Clip bioclimatic variables global TIFF to Forgenius region.
###
echo "--------------------------------------------------"
start=$(date +%s)

echo "================"
echo "===> $name"
echo "================"

for var in "ai" "bio1" "bio2" "bio4" "clt_max"
do
	gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/$var.tif" "$clip/$var.tif"
done

###
# Clip integer point variables.
###
for var in "kg0" "kg3" "kg4" "kg5"
do
	gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/${var}.tif" "$clip/${var}.tif"
done

###
# Clip monthly.
###
for name in "pr" "tas"
do

	echo "================"
	echo "===> $name"
	echo "================"

	###
	# Clip files.
	###
	full="${path}/Chelsa/1981-2010/Full/$name"
	clip="${path}/Chelsa/1981-2010/ForgeniusClipped/name"
	for month in "01" "02"
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
