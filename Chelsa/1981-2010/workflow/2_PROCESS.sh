#!/bin/sh

###
# Process data: import GeoJSON data, process variables and dump to data folder.
###
start=$(date +%s)

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
