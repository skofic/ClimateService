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
# Execute script.
###
epoc="$path/Chelsa/1981-2010"
cmd="${epoc}/workflow/MERGE.sh"
$cmd | tee "${epoc}/log/5_MERGE.log"
