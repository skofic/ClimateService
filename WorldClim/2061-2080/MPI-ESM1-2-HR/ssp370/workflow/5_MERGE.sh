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
epoc="${path}/WorldClim/2061-2080/MPI-ESM1-2-HR/ssp370"
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
# Remove processed CSV and JSONL files.
# We do this here because we assume merging was successful.
###
for name in "bio"
do
	rm -f "${epoc}/data/${name}.csv.gz"
done

for name in "pr" "tasmax" "tasmin"
do
	rm -f "${epoc}/data/${name}.jsonl.gz"
done
