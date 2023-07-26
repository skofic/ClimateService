#!/bin/sh

###
# Clip mean temperature maps to EUFGIS region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
name="tas"

###
# Parameters.
###
epoc="${path}/Chelsa/1981-2010"
full="${epoc}/Full/${name}"
clip="${epoc}/ForgeniusClipped/${name}"
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"


echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip precipitation global TIFF to Forgenius region.
###
cmd="${path}/Chelsa/script_geo/clip.sh"
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do
	$cmd "${full}/${name}_${month}.tif" "${clip}/${name}_${month}.tif" "$poly"
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
