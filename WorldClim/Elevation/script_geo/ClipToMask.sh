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
clip="${epoc}/Clipped"

echo "--------------------------------------------------"
echo "<== ${full}/${name}.tif"
echo "==> ${clip}/${name}.tif"
start=$(date +%s)

###
# Clip map.
###
cmd="${path}/WorldClim/script_geo/clip_int16.sh"
$cmd "${full}/${name}.tif" \
	 "${clip}/${name}.tif" \
	 "$poly" \
	 "$pnam"
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
