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
# Globals.
###
name="tasmax"
peri="2041_2070"
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

###
# Start timer.
###
echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Call download script.
###
cmd="${path}/Chelsa/script_geo/download.sh"
$cmd "$epoc" \
	 "$name" \
	 "${path}/Chelsa/config/path_${peri}_${name}.txt"
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
