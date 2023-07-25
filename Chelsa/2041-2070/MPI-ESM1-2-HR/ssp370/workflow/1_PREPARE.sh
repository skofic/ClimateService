#!/bin/sh

###
# Prepare data: download, clip to region and convert to GeoJSON.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Execute script.
###
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/PREPARE.sh"
$cmd | tee "${epoc}/log/1_PREPARE.log"
