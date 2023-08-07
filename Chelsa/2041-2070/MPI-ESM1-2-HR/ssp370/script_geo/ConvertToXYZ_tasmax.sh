#!/bin/sh

###
# Convert precipitation maps to CSV.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Convert maximum temperature variables to CSV."
echo "====================================================================="

###
# Globals.
###
name="tasmax"
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
from="${epoc}/ForgeniusClipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Convert clipped precipitation variables to CSV format.
###
cmd="${path}/Chelsa/script_geo/convert.sh"
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do

	###
	# Convert to CSV and gzip.
	###
	$cmd "${from}/${name}_${month}.tif" "${dest}/${name}_${month}.csv"
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
echo "2041-2070 convert_tasmax.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
