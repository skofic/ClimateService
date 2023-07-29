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
# Execute script.
###
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/COMBINE_MONTHLY.sh"
$cmd | tee "${epoc}/log/4_COMBINE_MONTHLY.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
