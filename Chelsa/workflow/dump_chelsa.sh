#!/bin/sh

###
# Dump Chelsa.
#
# This script will:
# - merge all Chelsa period data into a dump
# - dump Chelsa map collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection_map="Chelsa"
collection_chelsa="ChelsaMap"
cmd="${path}/Chelsa/script_data/dump.sh"

echo "**************************************************"
echo "**************************************************"
echo "*** dump_chelsa.sh"
echo "**************************************************"
echo "**************************************************"
DUMP_CHELSA_START=$(date +%s)

###
# Dump Chelsa.
###
$cmd "${path}/${collection_chelsa}.jsonl.gz" \
	 "${path}/Chelsa/script_query/merge_chelsa.aql" \
	 "{}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Dump Chelsa map.
###
$cmd "${path}/${collection_map}.jsonl.gz" \
	 "${path}/Chelsa/script_query/export_points.aql" \
	 "{\"@@collection\": map_chelsa}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

DUMP_CHELSA_END=$(date +%s)
elapsed=$((DUMP_CHELSA_END-DUMP_CHELSA_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** dump_chelsa.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
