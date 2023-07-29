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
# Execute script.
###
epoc="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/PROCESS.sh"
$cmd | tee "${epoc}/log/2_PROCESS.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
