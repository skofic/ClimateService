#!/bin/sh

###
# Combine bioclimatic data.
#
# Collect all individual bioclimatic variables into a single collection,
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
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
cmd="${epoc}/workflow/COMBINE_BIO.sh"
$cmd | tee "${epoc}/log/3_COMBINE_BIO.log"
