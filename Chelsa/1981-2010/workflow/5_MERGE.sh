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
cmd="${path}/Chelsa/1981-2010/workflow/MERGE.sh"
$cmd | tee "${path}/Chelsa/1981-2010/log/5_MERGE.log"
