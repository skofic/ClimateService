#!/bin/sh

###
# Download and clip maps.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= DOWNLOAD FILES"
echo "=================================================="
start=$(date +%s)

for code in "bio" "pr" "tas" "tasmax" "tasmin"
do

	echo "--------------------------------------------------"
	echo "$code"
	echo "--------------------------------------------------"
	cmd="${path}/script_geo/download_${code}.sh"
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
echo "= DOWNLOAD FILES: $elapsed seconds"
echo "=================================================="
echo ""
