#!/bin/sh

###
# Merge data.
#
# Merge bioclimatic and monthly data into the chelsa collection.
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
# 1. Load bioclimatic data into collection.
# 2. Merge monthly data into collection.

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "TOTAL TIME: $elapsed seconds"
echo ""
