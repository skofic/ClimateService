#!/bin/sh

###
# Create Chelsa database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Execute script.
###
cmd="${path}/Chelsa/workflow/CREATE.sh"
$cmd | tee "${path}/Chelsa/log/1_CREATE.log"
