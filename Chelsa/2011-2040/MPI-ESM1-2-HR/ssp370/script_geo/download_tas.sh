#!/bin/sh

###
# Download average temperature files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Download mean temperature data."
echo "====================================================================="

###
# Globals.
###
name="tas"
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"

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
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
