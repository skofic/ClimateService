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
epoc="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
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
# Remove processed CSV files.
# We do this here because we assume merging was successful.
###
for folder in "pr" "tas" "tasmax" "tasmin"
do
	rm -f "${epoc}/data/${folder}/*.csv.gz"
done
