#!/bin/sh

###
# Combine annual data.
#
# Collect all individual bioclimatic variables into a single collection,
# group all variable by geographic location and dump result,
# load result into a specific collection.
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
echo "*** COMBINE_ANNUAL.sh"
echo "**************************************************"
COMBINE_bio_START=$(date +%s)
	
###
# Stack all data into a single collection.
###
cmd="${epoc}/script_data/combine_annual.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Import combined data in collection.
###
cmd="${epoc}/script_data/load_annual.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

COMBINE_bio_END=$(date +%s)
elapsed=$((COMBINE_bio_END-COMBINE_bio_START))
echo ""
echo "**************************************************"
echo "*** COMBINE_ANNUAL.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
