#!/bin/sh

###
# Clip bioclimatic maps to EUFGIS region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip bioclimatic variables to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
name="bio"
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
# Clip maps.
###
cmd="${path}/WorldClim/script_geo/clip.sh"
for var in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19"
do
	$cmd "${full}/${var}.tif" "${clip}/${var}.tif" "$poly"
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
