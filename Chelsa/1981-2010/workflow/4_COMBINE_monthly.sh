#!/bin/sh

###
# Combine monthly data.
#
# Collect all individual monthly variables into a single collection,
# group all variable by geographic location and dump result,
# load result into a specific collection.
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
cmd="${path}/Chelsa/1981-2010/script/combine_monthly.sh"
$cmd

cmd="${path}/Chelsa/1981-2010/script/dump_monthly.sh"
$cmd

cmd="${path}/Chelsa/1981-2010/script/load_monthly.sh"
$cmd

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "TOTAL TIME: $elapsed seconds"
echo ""