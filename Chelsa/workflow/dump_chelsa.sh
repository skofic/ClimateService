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
collection="map_chelsa"
collection_map="ChelsaMap"
collection_chelsa="Chelsa"

echo "**************************************************"
echo "**************************************************"
echo "*** dump_chelsa.sh"
echo "**************************************************"
echo "**************************************************"
DUMP_CHELSA_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump Chelsa properties"
echo "*** into ${path}/${collection_chelsa}.jsonl.gz"
echo "**************************************************"

###
# Dump Chelsa.
# Iterate Chelsa geometries collection loading all
# relative period records matching the geometry and
# merge all records recursively, dumping the result.
###
cmd="${path}/Chelsa/script_data/dump.sh"
$cmd "${path}/${collection_chelsa}.jsonl.gz" \
	 "${path}/Chelsa/script_query/merge_chelsa.aql" \
	 "{\"@@collection\": \"$collection\"}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo ""
echo "**************************************************"
echo "*** Dump Chelsa geometries"
echo "*** into ${path}/${collection_map}.jsonl.gz"
echo "**************************************************"

###
# Dump Chelsa map.
# Dump the Cjelsa geometries collection.
###
cmd="${path}/Chelsa/script_data/save.sh"
$cmd "${path}/${collection_map}.jsonl.gz" \
	 "$collection"
# echo "--------------------------------------------------"
# echo "$cmd"
# echo "${path}/${collection_map}.jsonl.gz"
# echo "$collection"
# echo "--------------------------------------------------"
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
