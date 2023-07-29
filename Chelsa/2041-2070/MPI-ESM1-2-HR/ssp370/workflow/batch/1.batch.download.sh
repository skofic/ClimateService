#!/bin/sh

###
# Download files in batch mode.
# Will launch bio and monthly downloads in parallel.
# You will need to check if the jobs finished correctly.
#
# The scripts that will be run in batch mode can be found in the script_geo folder:
#
# download_bio.log
# download_pr.log
# download_tas.log
# download_tasmax.log
# download_tasmin.log
#
# Before running other batch scripts you
# MUST ENSURE THIS BATCH HAS COMPLETED:
# it downloads files used by other scripts.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
scripts="${epoc}/script_geo"

###
# Launch batches.
###
for name in "bio" "pr" "tas" "tasmax" "tasmin"
do
	cmd="${scripts}/download_${name}.sh"
	nohup $cmd &
done
