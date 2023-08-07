#!/bin/sh

###
# Convert map to CSV.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Convert map to CSV."
echo "====================================================================="

###
# Globals.
###
name="elevation"
epoc="${path}/WorldClim/Elevation"

###
# Parameters.
###
from="${epoc}/Clipped"
dest="${epoc}/CSV"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Convert clipped bioclimatic variables to CSV format.
###
cmd="${path}/WorldClim/script_geo/convert.sh"
$cmd "${from}/${name}.tif" "${dest}/${name}.csv"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
