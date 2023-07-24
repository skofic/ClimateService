#!/bin/sh

###
# Prepare data: download, clip to region and convert to GeoJSON.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
script "${path}/Chelsa/1981-2010/log/1_PREPARE.log"

echo "**************************************************"
echo "*** PREPARE.sh"
echo "**************************************************"
PREPARE_START=$(date +%s)
	
###
# Download full maps.
###
cmd="${path}/Chelsa/1981-2010/workflow/download.sh"
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
cmd="${path}/Chelsa/1981-2010/workflow/clip.sh"
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
cmd="${path}/Chelsa/1981-2010/workflow/convert.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove downloaded and clipped maps,
# leaving only the contents of the CSV folder.
###
for directory in "Full" "ForgeniusClipped"
do
	
	for folder in "bio" "pr" "tas" "tasmax" "tasmin"
	do
		rm -fv "${path}/Chelsa/1981-2010/${directory}/${folder}/*.tif"
	done
	
done

PREPARE_END=$(date +%s)
elapsed=$((PREPARE_END-PREPARE_START))
echo ""
echo "**************************************************"
echo "*** PREPARE.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
