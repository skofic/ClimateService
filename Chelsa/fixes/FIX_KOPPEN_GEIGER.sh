#!/bin/sh

###
# Fix Chelsa Köppen/Geiger enumerations.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
FIX_KOPPEN_GEIGER_START=$(date +%s)

###
# Add and fix geometries.
##
echo ""
echo ">>> DUMP FIXED DATA >>>"
echo ""
cmd="${path}/Chelsa/fixes/dump_koppen_geiger_enums.sh"
$cmd

###
# Load fixes into database.
##
echo ""
echo "<<< LOAD FIXED DATA <<<"
echo ""
cmd="${path}/Chelsa/fixes/load_koppen_geiger_enums.sh"
$cmd

FIX_KOPPEN_GEIGER_END=$(date +%s)
elapsed=$((FIX_KOPPEN_GEIGER_END-FIX_KOPPEN_GEIGER_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> FIX_KOPPEN_GEIGER.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
