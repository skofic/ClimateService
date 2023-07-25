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
epoc="$path/Chelsa/1981-2010"
cmd="${epoc}/workflow/PROCESS.sh"
$cmd | tee "${epoc}/log/2_PROCESS.log"
