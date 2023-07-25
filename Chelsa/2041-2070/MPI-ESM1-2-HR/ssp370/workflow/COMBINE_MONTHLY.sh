#!/bin/sh

###
# Combine monthly data.
#
# Collect all individual monthly variables into a single collection,
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
epoc="$path/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

###
# Remove contents of the CSV folder.
# We do this here, because at this point
# only the files in the data directory are relevant.
# Note that the data folder is not touched yet.
###
for folder in "pr" "tas" "tasmax" "tasmin"
do
	rm -fv "${epoc}/CSV/${folder}/*.csv.gz"
done

echo "**************************************************"
echo "*** COMBINE_monthly.sh"
echo "**************************************************"
COMBINE_monthly_START=$(date +%s)
	
###
# Stack all data into a single collection.
###
cmd="${epoc}/script_data/combine_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Group stacked data by coordinate abd dump export file.
###
cmd="${epoc}/script_data/dump_monthly.sh"
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
cmd="${epoc}/script_data/load_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

COMBINE_monthly_END=$(date +%s)
elapsed=$((COMBINE_monthly_END-COMBINE_monthly_START))
echo ""
echo "**************************************************"
echo "*** COMBINE_monthly.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
