#!/bin/sh

###
# Clip GeoTIFF maps to EUFGIS region in batch mode.
# Will launch clipping scripts in parallel.
# You will need to check if the jobs finished correctly.
#
# The scripts that will be run in batch mode can be found in the script_geo folder:
#
# ClipToForgeniusMask_bio.log
# ClipToForgeniusMask_pr.log
# ClipToForgeniusMask_tas.log
# ClipToForgeniusMask_tasmax.log
# ClipToForgeniusMask_tasmin.log
#
# Before running this batch:
# you MUST HAVE RUN batch.download.sh.
# Before running other batch scripts you
# MUST ENSURE THIS BATCH HAS COMPLETED:
# it processes files used by other scripts.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="$path/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
scripts="${epoc}/script_geo"

###
# Launch batches.
###
for name in "bio" "pr" "tas" "tasmax" "tasmin"
do
	cmd="${scripts}/ClipToForgeniusMask_${name}.sh"
	nohup $cmd &
done
