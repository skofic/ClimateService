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
epoc="${path}/WorldClim/1970-2000"
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

###
# Remove converted CSV files in monthly folders.
# We do this here because we assume combining was successful.
###
for folder in "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
do
	rm -f "${epoc}/data/${folder}/*.csv.gz"
done
