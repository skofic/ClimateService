#!/bin/sh

###
# Prepare data: download, clip to region and convert to GeoJSON.
###
start=$(date +%s)

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Run workflow scripts.
###
cmd="${path}/Chelsa/1981-2010/workflow/download.sh"
$cmd

cmd="${path}/Chelsa/1981-2010/workflow/clip.sh"
$cmd

cmd="${path}/Chelsa/1981-2010/workflow/convert.sh"
$cmd

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "TOTAL TIME: $elapsed seconds"
echo ""
