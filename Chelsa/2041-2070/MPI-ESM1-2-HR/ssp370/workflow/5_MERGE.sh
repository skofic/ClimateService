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
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/MERGE.sh"

###
# Execute script.
###
$cmd | tee "${epoc}/log/5_MERGE.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
