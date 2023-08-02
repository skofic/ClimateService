#!/bin/sh

###
# Clip average temperature maps to EUFGIS region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip monthly average temperature variables to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
name="tas"
epoc="${path}/WorldClim/1970-2000"

###
# Parameters.
###
full="${epoc}/Full/${name}"
clip="${epoc}/ForgeniusClipped/${name}"
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"


echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Clip average temperature global TIFF to Forgenius region.
###
cmd="${path}/WorldClim/script_geo/clip.sh"
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
