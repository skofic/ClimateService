#!/bin/sh

###
# Download minimum temperature files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Download minimum temperature data."
echo "====================================================================="

###
# Start timer.
###
echo "==> tasmin"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Call download script.
###
cmd="${path}/Chelsa/script_geo/download.sh"
$cmd "${path}/Chelsa/1981-2010" "tasmin" "path_1981_2010_tasmin.txt"
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
