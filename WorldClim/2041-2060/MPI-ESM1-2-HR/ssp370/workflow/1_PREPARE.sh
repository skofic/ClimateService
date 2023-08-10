#!/bin/sh

###
# Prepare data.
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
epoc="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/PREPARE.sh"

###
# Execute script.
###
$cmd | tee "${epoc}/log/1_PREPARE.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
