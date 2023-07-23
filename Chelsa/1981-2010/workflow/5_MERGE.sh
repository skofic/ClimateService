#!/bin/sh

###
# Merge data.
#
# Merge bioclimatic and monthly data into the chelsa collection.
###
start=$(date +%s)

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Run workflow scripts.
###
# 1. Load bioclimatic data into one collection.
# 2. Load monthly data into another collection.
# 3. Insert bioclimatic data into merge collection.
# 4. Upsert monthly data into merge collection.

end=$(date +%s)
elapsed=$((end-start))
echo ""
echo "TOTAL TIME: $elapsed seconds"
echo ""
