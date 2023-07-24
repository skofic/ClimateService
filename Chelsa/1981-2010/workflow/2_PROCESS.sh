#!/bin/sh

###
# Process data: import GeoJSON data, process variables and dump to data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
script "${path}/Chelsa/1981-2010/log/2_PROCESS.log"

echo "**************************************************"
echo "*** PROCESS.sh"
echo "**************************************************"
PROCESS_START=$(date +%s)
	
###
# Run workflow scripts.
###
cmd="${path}/Chelsa/1981-2010/script_data/process_bio.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

cmd="${path}/Chelsa/1981-2010/script_data/process_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove contents of the CSV folder.
###
for folder in "bio" "pr" "tas" "tasmax" "tasmin"
do
	rm -fv "${path}/Chelsa/1981-2010/CSV/${folder}/*.csv.gz"
done

PROCESS_END=$(date +%s)
elapsed=$((PROCESS_END-PROCESS_START))
echo ""
echo "**************************************************"
echo "*** PROCESS.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
