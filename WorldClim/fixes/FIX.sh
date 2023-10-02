#!/bin/sh

###
# Fix WorldClim database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
FIX_WORLDCLIM_START=$(date +%s)

###
# Add and fix geometries.
##
echo ""
echo ">>> DUMP FIXED DATA >>>"
echo ""
cmd="${path}/WorldClim/fixes/1_fix_polygon.sh"
$cmd

###
# Load fixes into database.
##
echo ""
echo "<<< LOAD FIXED DATA <<<"
echo ""
cmd="${path}/WorldClim/fixes/2_load_data.sh"
$cmd

FIX_WORLDCLIM_END=$(date +%s)
elapsed=$((FIX_WORLDCLIM_END-FIX_WORLDCLIM_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> FIX_WORLDCLIM.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
