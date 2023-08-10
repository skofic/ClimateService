#!/bin/sh

###
# Prepare data: download, clip to region and convert to GeoJSON.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"

echo "**************************************************"
echo "*** PREPARE.sh"
echo "**************************************************"
PREPARE_START=$(date +%s)
	
###
# Download full maps.
###
cmd="${epoc}/script_geo/download_concurrent.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Clip full maps to EUFGIS region.
###
cmd="${epoc}/script_geo/clip_concurrent.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Convert clipped maps to CSV (longitude, latitude and value).
###
cmd="${epoc}/script_geo/convert_concurrent.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

PREPARE_END=$(date +%s)
elapsed=$((PREPARE_END-PREPARE_START))
echo ""
echo "**************************************************"
echo "*** PREPARE.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
