#!/bin/sh

###
# Prepare data: download, clip to region and convert to GeoJSON.
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
cmd="${path}/Chelsa/1981-2010/workflow/01.download.sh"
$cmd

cmd="${path}/Chelsa/1981-2010/workflow/02.clip.sh"
$cmd

cmd="${path}/Chelsa/1981-2010/workflow/03.convert.sh"
$cmd

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "TOTAL TIME: $elapsed seconds"
echo ""
