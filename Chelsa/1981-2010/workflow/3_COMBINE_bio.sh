#!/bin/sh

###
# Combine bioclimatic data.
#
# Collect all individual bioclimatic variables into a single collection,
# group all variable by geographic location and dump result,
# load result into a specific collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
script "${path}/Chelsa/1981-2010/log/3_COMBINE_BIO.log"

###
# Remove contents of the CSV folder.
# We do this here, because at this point
# only the files in the data directory are relevant.
###
for folder in "bio" "pr" "tas" "tasmax" "tasmin"
do
	rm -fv "${path}/Chelsa/1981-2010/CSV/${folder}/*.csv.gz"
done

echo "**************************************************"
echo "*** COMBINE_bio.sh"
echo "**************************************************"
COMBINE_bio_START=$(date +%s)
	
###
# Run workflow scripts.
###
cmd="${path}/Chelsa/1981-2010/script_data/combine_bio.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

cmd="${path}/Chelsa/1981-2010/script_data/dump_bio.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

cmd="${path}/Chelsa/1981-2010/script_data/load_bio.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

COMBINE_bio_END=$(date +%s)
elapsed=$((COMBINE_bio_END-COMBINE_bio_START))
echo ""
echo "**************************************************"
echo "*** COMBINE_bio.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo ""
