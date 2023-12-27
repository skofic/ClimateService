#!/bin/sh

###
# Restore ShapeData and DroughtObservatory.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

###
# Globals.
###
collection_rs="ShapeData"
collection_do="DroughtObservatory"
bdir_rs="home/geouser/Backup/RemoteSensing"
bdir_do="home/geouser/Backup/DroughtObservatory"

###
# Parameters.
###
dump_rs="${bdir_rs}/${collection_rs}.jsonl.gz"
dump_do="${bdir_do}/${collection_do}.jsonl.gz"

echo "dump_rs"
echo "dump_do"

# echo "**************************************************"
# echo "**************************************************"
# echo "*** 0_restore_data.sh"
# echo "**************************************************"
# echo "**************************************************"
# RESTORE_DATA_START=$(date +%s)
# 
# echo ""
# echo "**************************************************"
# echo "*** Restore Chelsa geometries"
# echo "*** from ${path}/${dump_map_name}.jsonl.gz"
# echo "**************************************************"
# 
# ###
# # Import data from JSONL file.
# ###
# arangoimport \
# 	--server.endpoint "$host" \
# 	--server.database "GeoService" \
# 	--server.username "$user" \
# 	--server.password "$pass" \
# 	--file "$mdump" \
# 	--type "jsonl" \
# 	--collection "$collection_map" \
# 	--create-collection true \
# 	--create-collection-type "document" \
# 	--auto-rate-limit true \
# 	--overwrite true
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi
# 
# echo ""
# echo "**************************************************"
# echo "*** Restore Chelsa properties"
# echo "*** from ${path}/${dump_chelsa_name}.jsonl.gz"
# echo "**************************************************"
# 
# ###
# # Import data from JSONL file.
# ###
# arangoimport \
# 	--server.endpoint "$host" \
# 	--server.database "GeoService" \
# 	--server.username "$user" \
# 	--server.password "$pass" \
# 	--file "$ddump" \
# 	--type "jsonl" \
# 	--collection "$collection_data" \
# 	--create-collection true \
# 	--create-collection-type "document" \
# 	--auto-rate-limit true \
# 	--overwrite true
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi
# 
# RESTORE_DATA_END=$(date +%s)
# elapsed=$((RESTORE_DATA_END-RESTORE_DATA_START))
# echo ""
# echo "**************************************************"
# echo "**************************************************"
# echo "*** 0_restore_data.sh - TOTAL TIME: $elapsed seconds"
# echo "**************************************************"
# echo "**************************************************"
# echo ""
