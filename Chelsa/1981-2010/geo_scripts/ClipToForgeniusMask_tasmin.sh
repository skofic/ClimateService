#!/bin/sh

###
# Clip maps to useful region.
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

###
# Parameters.
###
name="tasmin"
full="${path}/Chelsa/1981-2010/Full/${name}"
clip="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip monthly mean daily minimum ERA5 2m. air temperature global TIFF to Forgenius region.
###
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do
	gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/${name}_${month}.tif" "$clip/${name}_${month}.tif"
done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
