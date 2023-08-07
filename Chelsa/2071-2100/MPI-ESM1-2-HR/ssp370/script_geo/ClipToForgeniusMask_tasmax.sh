#!/bin/sh

###
# Clip maximum temperature maps to EUFGIS region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip monthly maximum temperature variables to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
name="tasmax"
epoc="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
full="${epoc}/Full/${name}"
clip="${epoc}/ForgeniusClipped/${name}"


echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Clip precipitation global TIFF to Forgenius region.
###
cmd="${path}/Chelsa/script_geo/clip_float32.sh"
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do
	$cmd "${full}/${name}_${month}.tif" "${clip}/${name}_${month}.tif" "$poly" "$pnam"
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
echo "--------------------------------------------------"
echo "2071-2100 clip_tasmax.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
