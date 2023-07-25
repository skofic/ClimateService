#!/bin/sh

###
# Process data: import GeoJSON data, process variables and dump to data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="$path/Chelsa/1981-2010"

###
# Remove downloaded and clipped maps,
# leaving only the contents of the CSV folder.
# We do this here, because at this point
# you will not use GeoTIFF files any more.
###
for directory in "Full" "ForgeniusClipped"
do
	
	for folder in "bio" "pr" "tas" "tasmax" "tasmin"
	do
		rm -fv "${epoc}/${directory}/${folder}/*.tif"
	done
	
done

echo "**************************************************"
echo "*** PROCESS.sh"
echo "**************************************************"
PROCESS_START=$(date +%s)
	
###
# Run workflow scripts.
###
cmd="${epoc}/script_data/process_bio.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

cmd="${epoc}/script_data/process_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

PROCESS_END=$(date +%s)
elapsed=$((PROCESS_END-PROCESS_START))
echo ""
echo "**************************************************"
echo "*** PROCESS.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
