#!/bin/sh

###
# Clip maps to EUFGIS region.
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
echo "= CLIP FILES"
echo "=================================================="
start=$(date +%s)

for code in "bio" "pr" "srad" "tas" "tasmax" "tasmin" "vapr" "wind"
do

	echo "--------------------------------------------------"
	echo "$code"
	echo "--------------------------------------------------"
	cmd="${epoc}/script_geo/ClipToMask_${code}.sh"
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
echo "= CLIP FILES: $elapsed seconds"
echo "=================================================="
echo ""
