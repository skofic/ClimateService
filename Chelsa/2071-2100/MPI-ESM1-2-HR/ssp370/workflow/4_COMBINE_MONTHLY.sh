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
epoc="$path/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/COMBINE_MONTHLY.sh"
$cmd | tee "${epoc}/log/4_COMBINE_MONTHLY.log"
