#!/bin/sh

###
# Convert bioclimatic maps to CSV.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Convert maps to CSV."
echo "====================================================================="

###
# Globals.
###
cmd="${path}/WorldClim/script_geo/convert.sh"
epoc="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
from="${epoc}/Clipped"
dest="${epoc}/CSV"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Convert clipped maps to CSV format.
###
for var in "bio" "pr" "tasmax" "tasmin"
do

	###
	# Convert to CSV and gzip.
	###
	echo "=> ${var}"
	$cmd "${from}/${var}.tif" "${dest}/${var}.csv"
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
