#!/bin/sh

###
# Process data.
#
# import GeoJSON data,
# process variables
# and dump to data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/PROCESS.sh"

###
# Execute script.
###
$cmd | tee "${epoc}/log/2_PROCESS.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove maps.
# We do it here assuming the current script was successful.
###
for directory in "Full" "ForgeniusClipped"
do
	
	for folder in "bio" "pr" "tas" "tasmax" "tasmin"
	do
		rm -f "${epoc}/${directory}/${folder}/*.tif"
	done
	
done
