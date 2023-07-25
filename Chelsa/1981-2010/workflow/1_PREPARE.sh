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
epoc="$path/Chelsa/1981-2010"
cmd="${epoc}/workflow/PREPARE.sh"
$cmd | tee "${epoc}/log/1_PREPARE.log"
