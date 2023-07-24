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
cmd="${path}/Chelsa/1981-2010/workflow/PREPARE.sh"
$cmd | tee "${path}/Chelsa/1981-2010/log/1_PREPARE.log"
