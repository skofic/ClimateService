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
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/PROCESS.sh"
$cmd | tee "${epoc}/log/2_PROCESS.log"
