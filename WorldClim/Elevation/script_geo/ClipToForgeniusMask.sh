#!/bin/sh

###
# Clip full map to EUFGIS region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip full map to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
name="elevation"
epoc="${path}/WorldClim/Elevation"

###
# Parameters.
###
full="${epoc}/Full"
clip="${epoc}/ForgeniusClipped"
poly="${path}/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Clip map.
###
cmd="${path}/WorldClim/script_geo/clip.sh"
$cmd "${full}/${name}.tif" "${clip}/${name}.tif" "$poly"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
