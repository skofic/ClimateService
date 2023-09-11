#!/bin/sh

###
# Convert clipped bioclimatic variables to CSV format.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/GlobalDroughtObservatory/FAPAN"
start=$(date +%s)

echo "=================================================="
echo "= PREPARE FILES"
echo "=================================================="

###
# Expand and place files.
###
cmd="${epoc}/workflow/expand.sh"
$cmd | tee "${epoc}/log/1_expand.log"

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= PREPARE FILES: $elapsed seconds"
echo "=================================================="
echo ""
