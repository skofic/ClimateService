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
# Globals.
###
epoc="${path}/Chelsa/1981-2010"

###
# Remove files from the data directory.
# We assume here that the two previous steps were successful.
# Only the properties folder will be untouched.
###
for folder in "bio" "pr" "tas" "tasmax" "tasmin"
do
	rm -fv "${epoc}/data/${folder}/*.csv.gz"
done

echo "**************************************************"
echo "*** MERGE.sh"
echo "**************************************************"
MERGE_START=$(date +%s)
	
###
# Dump bioclimatic coordinates.
###
cmd="${epoc}/script_data/dump_coordinates.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
	
###
# Load bioclimatic coordinates.
###
cmd="${epoc}/script_data/load_coordinates.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
	
###
# Dump merged data.
###
cmd="${epoc}/script_data/dump_merged.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove files from the properties folder in the data directory.
# We assume here that all previous scripts have been run,
# after this point we should be left with the "properties.jsonl.gz"
# at the root level of the period.
###
for folder in "properties"
do
	rm -fv "${epoc}/data/${folder}/*.csv.gz"
done

MERGE_END=$(date +%s)
elapsed=$((MERGE_END-MERGE_START))
echo ""
echo "**************************************************"
echo "*** MERGE.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
