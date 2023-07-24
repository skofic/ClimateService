#!/bin/sh

###
# Combine monthly data.
#
# Collect all individual monthly variables into a single collection,
# group all variable by geographic location and dump result,
# load result into a specific collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
script "${path}/Chelsa/1981-2010/log/4_COMBINE_MONTHLY.log"

echo "**************************************************"
echo "*** COMBINE_monthly.sh"
echo "**************************************************"
COMBINE_monthly_START=$(date +%s)
	
###
# Run workflow scripts.
###
cmd="${path}/Chelsa/1981-2010/script_data/combine_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

cmd="${path}/Chelsa/1981-2010/script_data/dump_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

cmd="${path}/Chelsa/1981-2010/script_data/load_monthly.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove contents of the data folder.
###
for folder in "pr" "tas" "tasmax" "tasmin"
do
	rm -fv "${path}/Chelsa/1981-2010/data/${folder}/*.csv.gz"
done

COMBINE_monthly_END=$(date +%s)
elapsed=$((COMBINE_monthly_END-COMBINE_monthly_START))
echo ""
echo "**************************************************"
echo "*** COMBINE_monthly.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
