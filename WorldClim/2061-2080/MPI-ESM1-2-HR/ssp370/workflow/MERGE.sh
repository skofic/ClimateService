#!/bin/sh

###
# Merge data.
#
# Merge bioclimatic and monthly data into the chelsa collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/WorldClim/2061-2080/MPI-ESM1-2-HR/ssp370"

echo "**************************************************"
echo "*** MERGE.sh"
echo "**************************************************"
MERGE_START=$(date +%s)
	
###
# Dump annual and monthly coordinates.
###
cmd="${epoc}/script_data/dump_coordinates.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
	
###
# Combine annual and monthly coordinates.
###
cmd="${epoc}/script_data/load_coordinates.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
	
###
# Dump merged data.
###
cmd="${epoc}/script_data/dump_merged.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

MERGE_END=$(date +%s)
elapsed=$((MERGE_END-MERGE_START))
echo ""
echo "**************************************************"
echo "*** MERGE.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
