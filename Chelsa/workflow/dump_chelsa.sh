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
collection_map="map_chelsa"
collection_data="chelsa"
dump_map_name="ChelsaMap"
dump_chelsa_name="Chelsa"

###
# Parameters.
###
mdump="${path}/${dump_map_name}.jsonl.gz"
ddump="${path}/${dump_chelsa_name}.jsonl.gz"
query="${path}/Chelsa/script_query/merge_chelsa.aql"
query_map="${path}/Chelsa/script_query/dump_map.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** dump_chelsa.sh"
echo "**************************************************"
echo "**************************************************"
DUMP_CHELSA_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump Chelsa properties"
echo "*** into ${path}/${dump_chelsa_name}.jsonl.gz"
echo "**************************************************"

###
# Dump Chelsa.
# Iterate Chelsa geometries collection loading all
# relative period records matching the geometry and
# merge all records recursively, dumping the result.
###
cmd="${path}/Chelsa/script_data/dump.sh"
$cmd "$ddump" \
	 "$query" \
	 "{\"@@collection\": \"$collection_map\"}"
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
echo "*** into ${path}/${dump_map_name}.jsonl.gz"
echo "**************************************************"

###
# Dump Chelsa map.
# Dump the Chelsa geometries collection setting polygon as geometry.
###
cmd="${path}/Chelsa/script_data/dump.sh"
$cmd "$mdump" \
	 "$query_map" \
	 "{\"@@collection\": \"$collection_map\"}"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

echo ""
echo "**************************************************"
echo "*** Load Chelsa into database"
echo "*** dump ${path}/${dump_chelsa_name}.jsonl.gz"
echo "*** into collection $collection_data"
echo "**************************************************"

###
# Load chelsa.
###
cmd="${path}/Chelsa/script_data/load.sh"
$cmd "$ddump" \
	 "$collection_data"
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
