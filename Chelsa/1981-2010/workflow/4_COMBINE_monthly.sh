#!/bin/sh

###
# Combine monthly data.
#
# Collect all individual monthly variables into a single collection,
# group all variable by geographic location and dump result,
# load result into a specific collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Execute script.
###
cmd="${path}/Chelsa/1981-2010/workflow/COMBINE_MONTHLY.sh"
$cmd | tee "${path}/Chelsa/1981-2010/log/4_COMBINE_MONTHLY.log"
