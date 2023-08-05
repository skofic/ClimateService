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
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

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
		rm -f "${epoc}/${directory}/${folder}/*.tif"
	done
	
done

echo "**************************************************"
echo "*** PROCESS.sh"
echo "**************************************************"
PROCESS_START=$(date +%s)
	
###
# Process bioclimatic data.
###
cmd="${epoc}/script_data/process_annual.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Process monthly data.
###
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
