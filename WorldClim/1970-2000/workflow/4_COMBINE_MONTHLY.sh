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
epoc="${path}/WorldClim/1970-2000"
cmd="${epoc}/workflow/COMBINE_MONTHLY.sh"

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
for folder in "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
do
	rm -f "${epoc}/CSV/${folder}/*.csv.gz"
done
