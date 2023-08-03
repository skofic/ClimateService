#!/bin/sh

###
# Combine bioclimatic data.
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
# Execute script.
###
epoc="${path}/WorldClim/1970-2000"
cmd="${epoc}/workflow/COMBINE_ANNUAL.sh"
$cmd | tee "${epoc}/log/3_COMBINE_ANNUAL.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
