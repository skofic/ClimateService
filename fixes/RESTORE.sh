#!/bin/sh

###
# Restore Chelsa and WorldClim databases.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
RESTORE_START=$(date +%s)

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> RESTORE.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""

###
# Fix Chelsa.
##
echo ""
echo ">>> RESTORE CHELSA >>>"
echo ""
cmd="${path}/Chelsa/fixes/0_restore_data.sh"
$cmd

###
# Fix WorldClim.
##
echo ""
echo ">>> RESTORE WORLDCLIM >>>"
echo ""
cmd="${path}/WorldClim/fixes/0_restore_data.sh"
$cmd

RESTORE_END=$(date +%s)
elapsed=$((RESTORE__END-RESTORE_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> RESTORE.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
