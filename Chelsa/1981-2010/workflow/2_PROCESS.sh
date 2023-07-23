#!/bin/sh

###
# Process data: import GeoJSON data, process variables and dump to data folder.
###
start=$(date +%s)

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Run workflow scripts.
###
cmd="${path}/Chelsa/1981-2010/script/process_bio.sh"
$cmd
sleep 10

cmd="${path}/Chelsa/1981-2010/script/process_monthly.sh"
$cmd
sleep 10

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "TOTAL TIME: $elapsed seconds"
echo ""
