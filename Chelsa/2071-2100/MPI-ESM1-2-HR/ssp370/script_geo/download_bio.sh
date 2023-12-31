#!/bin/sh

###
# Download bioclimatic files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Download bioclimatic data."
echo "====================================================================="

###
# Globals.
###
name="bio"
epoc="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

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
	 "${path}/Chelsa/config/path_2071_2100_${name}.txt"
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
echo "--------------------------------------------------"
echo "2071-2100 download_bio.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
