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
name="tas"
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
full="${epoc}/Full/${name}"
clip="${epoc}/ForgeniusClipped/${name}"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip monthly mean daily ERA5 2m. air temperature global TIFF to Forgenius region.
###
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do
	gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$poly" -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$full/${name}_${month}.tif" "$clip/${name}_${month}.tif"
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
