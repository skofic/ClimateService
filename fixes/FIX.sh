#!/bin/sh

###
# Fix Chelsa and WorldClim databases.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
FIX_START=$(date +%s)

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> FIX.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""

###
# Fix Chelsa.
##
echo ""
echo ">>> FIX CHELSA >>>"
echo ""
cmd="${path}/Chelsa/fixes/FIX.sh"
$cmd

###
# Fix WorldClim.
##
echo ""
echo ">>> FIX WORLDCLIM >>>"
echo ""
cmd="${path}/WorldClim/fixes/FIX.sh"
$cmd

FIX_END=$(date +%s)
elapsed=$((FIX__END-FIX_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> FIX.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
