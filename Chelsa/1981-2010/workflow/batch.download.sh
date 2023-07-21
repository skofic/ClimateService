#!/bin/sh

###
# Download files in batch mode.
# Will launch bio and monthly downloads in parallel.
# You will need to check if the jobs finished correctly.
#
# The scripts that will be run in batch mode can be found in the geo_scripts folder:
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
	cmd="${scripts}/download_${name}.sh"
	nohup $cmd &
done
