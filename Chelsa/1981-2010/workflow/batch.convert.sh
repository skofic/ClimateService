#!/bin/sh

###
# Convert clipped GeoTIFF maps to GeoJSON in batch mode.
# Will launch conversion scripts in parallel.
# You will need to check if the jobs finished correctly.
#
# The scripts that will be run in batch mode can be found in the geo_scripts folder:
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
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

###
# Globals.
###
scripts="${path}/Chelsa/1981-2010/geo_scripts"

###
# Launch batches.
###
for name in "bio" "pr" "tas" "tasmax" "tasmin"
do
	cmd="${scripts}/ConvertToXYZ_${name}.sh"
	nohup $cmd &
done
