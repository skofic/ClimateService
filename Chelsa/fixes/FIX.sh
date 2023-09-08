#!/bin/sh

###
# Fix Chelsa database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
FIX_CHELSA=$(date +%s)

###
# Add and fix geometries.
##
echo ""
echo ">>> DUMP FIXED DATA >>>"
echo ""
cmd="${path}/Chelsa/fixes/1_fix_polygon.sh"
$cmd

###
# Load fixes into database.
##
echo ""
echo "<<< LOAD FIXED DATA <<<"
echo ""
cmd="${path}/Chelsa/fixes/2_load_data.sh"
$cmd

FIX_CHELSA_END=$(date +%s)
elapsed=$((FIX_CHELSA_END-FIX_CHELSA_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> FIX_CHELSA.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
