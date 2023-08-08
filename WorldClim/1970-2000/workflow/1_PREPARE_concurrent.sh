#!/bin/sh

###
# Prepare data.
# Concurrent version.
#
# Download GeoIFF maps,
# clip maps to useful region,
# convert maps to CSV files
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/WorldClim/1970-2000"
cmd="${epoc}/workflow/PREPARE_concurrent.sh"

###
# Execute script.
###
$cmd | tee "${epoc}/log/1_PREPARE_concurrent.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi