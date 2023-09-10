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
epoc="${path}/WorldClim/2021-2040"

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
