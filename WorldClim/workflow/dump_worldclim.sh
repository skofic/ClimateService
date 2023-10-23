#!/bin/sh

###
# Dump WorldClim.
#
# This script will:
# - merge all WorldClim period data into a dump
# - dump WorldClim map collection.
#
# Note that radius for data points is 0.004166665
# hardcoded in merge_worldclim.aql query.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection_map="map_worldclim"
collection_data="worldclim"
dump_map_name="WorldClimMap"
dump_worldclim_name="WorldClim"
epoc="${path}/WorldClim"

###
# Parameters.
###
mdump="${epoc}/data/${dump_map_name}.jsonl.gz"
ddump="${epoc}/data/${dump_worldclim_name}.jsonl.gz"
query="${epoc}/script_query/merge_worldclim.aql"
query_map="${epoc}/script_query/dump_map.aql"

echo "**************************************************"
echo "**************************************************"
echo "*** dump_worldclim.sh"
echo "**************************************************"
echo "**************************************************"
DUMP_WORLDCLIM_START=$(date +%s)

echo ""
echo "**************************************************"
echo "*** Dump WorldClim properties"
echo "*** into ${path}/${dump_worldclim_name}.jsonl.gz"
echo "**************************************************"

###
# Dump WorldClim.
# Iterate WorldClim geometries collection loading all
# relative period records matching the geometry and
# merge all records recursively, dumping the result.
###
cmd="${path}/WorldClim/script_data/dump.sh"
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
echo "*** Dump WorldClim geometries"
echo "*** into ${path}/${dump_map_name}.jsonl.gz"
echo "**************************************************"

###
# Dump WorldClim map.
# Dump the WorldClim geometries collection.
###
cmd="${path}/WorldClim/script_data/dump.sh"
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

# echo ""
# echo "**************************************************"
# echo "*** Load WorldClim into database"
# echo "*** dump ${path}/${dump_worldclim_name}.jsonl.gz"
# echo "*** into collection $collection_data"
# echo "**************************************************"
# 
# ###
# # Load worldclim.
# ###
# cmd="${path}/WorldClim/script_data/load.sh"
# $cmd "$ddump" \
# 	 "$collection_data"
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi

DUMP_WORLDCLIM_END=$(date +%s)
elapsed=$((DUMP_WORLDCLIM_END-DUMP_WORLDCLIM_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** dump_worldclim.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
