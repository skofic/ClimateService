#!/bin/sh

###
# Convert clipped GeoTIFF maps to GeoJSON in batch mode.
# Will launch conversion scripts in parallel.
# You will need to check if the jobs finished correctly.
#
# The scripts that will be run in batch mode can be found in the script_geo folder:
#
# ConvertToXYZ_bio.log
# ConvertToXYZ_pr.log
# ConvertToXYZ_tas.log
# ConvertToXYZ_tasmax.log
# ConvertToXYZ_tasmin.log
#
# Before running this batch:
# you MUST HAVE RUN batch.clip.sh.
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
epoc="$path/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
scripts="${epoc}/script_geo"

###
# Launch batches.
###
for name in "bio" "pr" "tas" "tasmax" "tasmin"
do
	cmd="${scripts}/ConvertToXYZ_${name}.sh"
	nohup $cmd &
done
