#!/bin/sh

###
# Download full maps.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/WorldClim/1970-2000"

echo "=================================================="
echo "= DOWNLOAD FILES"
echo "=================================================="
start=$(date +%s)

for code in "bio" "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
do

	echo "--------------------------------------------------"
	echo "$code"
	echo "--------------------------------------------------"
	cmd="${epoc}/script_geo/download_${code}.sh"
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
