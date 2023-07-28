#!/bin/sh

###
# Download maximum temperature files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Download maximum temperature data."
echo "====================================================================="

###
# Start timer.
###
echo "--------------------------------------------------"
echo "==> tasmax"
start=$(date +%s)

###
# Call download script.
###
cmd="${path}/Chelsa/script_geo/download.sh"
$cmd "${path}/Chelsa/1981-2010" "tasmax" "path_1981_2010_tasmax.txt"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# End timer.
###
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
