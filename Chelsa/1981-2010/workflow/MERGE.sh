#!/bin/sh

###
# Merge data.
#
# Merge bioclimatic and monthly data into the chelsa collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Remove contents of the monthly folders in the data directory.
# Run this script only after you are sure the 4_COMBINE_monthly.sh script works.
# Note that we keep the files in the properties folder as a safety backup.
###
for folder in "pr" "tas" "tasmax" "tasmin"
do
	rm -fv "${path}/Chelsa/1981-2010/data/${folder}/*.csv.gz"
done

echo "**************************************************"
echo "*** MERGE.sh"
echo "**************************************************"
MERGE_START=$(date +%s)
	
###
# Run workflow scripts.
###
# 1. Load bioclimatic data into one collection.
# 2. Load monthly data into another collection.
# 3. Insert bioclimatic data into merge collection.
# 4. Upsert monthly data into merge collection.
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

MERGE_END=$(date +%s)
elapsed=$((MERGE_END-MERGE_START))
echo ""
echo "**************************************************"
echo "*** MERGE.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
