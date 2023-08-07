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
epoc="${path}/WorldClim/1970-2000"
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
	
	for folder in "bio" "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
	do
		rm -f "${epoc}/${directory}/${folder}/*.tif"
	done
	
done
