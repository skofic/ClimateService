#!/bin/sh

###
# Download minimum temperature files.
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
$cmd "${path}/Chelsa/1981-2010" "tasmin" "path_1981_2010_tasmin.txt"

###
# End timer.
###
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
