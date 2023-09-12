#!/bin/sh

###
# Process files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/GlobalDroughtObservatory/FAPAR"
start=$(date +%s)

echo "=================================================="
echo "= PROCESS FILES"
echo "=================================================="

###
# Expand and place files.
###
cmd="${epoc}/workflow/process.sh"
$cmd | tee "${epoc}/log/3_process.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= PROCESS FILES: $elapsed seconds"
echo "=================================================="
echo ""
