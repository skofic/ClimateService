#!/bin/sh

###
# Download precipitation files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Download precipitation data."
echo "====================================================================="

###
# Start timer.
###
echo "--------------------------------------------------"
echo "==> pr"
start=$(date +%s)

###
# Call download script.
###
cmd="${path}/Chelsa/script_geo/download.sh"
$cmd "${path}/Chelsa/1981-2010" "pr" "path_1981_2010_pr.txt"
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
