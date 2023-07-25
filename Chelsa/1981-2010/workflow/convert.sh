#!/bin/sh

###
# Convert clipped bioclimatic variables to CSV format.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="$path/Chelsa/1981-2010"

echo "=================================================="
echo "= CONVERT FILES"
echo "=================================================="
start=$(date +%s)

for code in "bio" "pr" "tas" "tasmax" "tasmin"
do

	echo "--------------------------------------------------"
	echo "$code"
	echo "--------------------------------------------------"
	cmd="${epoc}/script_geo/ConvertToXYZ_${code}.sh"
	$cmd
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi

done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= CONVERT FILES: $elapsed seconds"
echo "=================================================="
echo ""
