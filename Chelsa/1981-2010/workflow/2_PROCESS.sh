#!/bin/sh

###
# Process data: import GeoJSON data, process variables and dump to data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Execute script.
###
cmd="${path}/Chelsa/1981-2010/workflow/PROCESS.sh"
$cmd | tee "${path}/Chelsa/1981-2010/log/2_PROCESS.log"
