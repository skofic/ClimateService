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
# Globals.
###
name="pr"
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
	 "${path}/Chelsa/config/path_2011_2040_${name}.txt"
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
echo "2071-2100 download_pr.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
