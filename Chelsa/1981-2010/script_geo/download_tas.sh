#!/bin/sh

###
# Download average temperature files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Start timer.
###
echo "--------------------------------------------------"
start=$(date +%s)

###
# Call download script.
###
cmd="${path}/Chelsa/script_geo/download.sh"
$cmd "${path}/Chelsa/1981-2010" "tas" "path_1981_2010_tas.txt"

###
# End timer.
###
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
