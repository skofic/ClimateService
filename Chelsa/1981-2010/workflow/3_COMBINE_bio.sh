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
epoc="$path/Chelsa/1981-2010"
cmd="${epoc}/workflow/COMBINE_BIO.sh"
$cmd | tee "${epoc}/log/3_COMBINE_BIO.log"
