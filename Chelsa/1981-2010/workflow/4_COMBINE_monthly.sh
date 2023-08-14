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
epoc="${path}/Chelsa/1981-2010"
cmd="${epoc}/workflow/COMBINE_MONTH.sh"

###
# Execute script.
###
$cmd | tee "${epoc}/log/4_COMBINE_MONTHLY.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove converted CSV files in monthly folders.
# We do this here because we assume combining was successful.
###
for folder in "pr" "tas" "tasmax" "tasmin"
do

	rm -f "${epoc}/CSV/${folder}/*.csv.gz"
	
done
