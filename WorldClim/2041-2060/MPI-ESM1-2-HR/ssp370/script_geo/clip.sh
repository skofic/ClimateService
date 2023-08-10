#!/bin/sh

###
# Clip maps to EUFGIS region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip maps to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
epoc="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
full="${epoc}/Full"
clip="${epoc}/Clipped"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Clip Float32 maps.
###
cmd="${path}/WorldClim/script_geo/clip_float32.sh"
for var in "bio" "tasmax" "tasmin"
do
	echo "==> Clip Float32 ${var}"
	$cmd "${full}/${var}.tif" \
		 "${clip}/${var}.tif" \
		 "$poly" \
		 "$pnam"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

###
# Clip Int16 maps.
###
cmd="${path}/WorldClim/script_geo/clip_int16.sh"
for var in "pr"
do
	echo "==> Clip Int16 ${var}"
	$cmd "${full}/${var}.tif" \
		 "${clip}/${var}.tif" \
		 "$poly" \
		 "$pnam"
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
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
