#!/bin/sh

###
# Clip mean temperature maps to region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Clip monthly mean temperature variables to EUFGIS region."
echo "====================================================================="

###
# Globals.
###
name="tas"
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
full="${epoc}/Full/${name}"
clip="${epoc}/Clipped/${name}"


echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Clip precipitation global TIFF to region.
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
echo "2011-2040 clip_tas.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
