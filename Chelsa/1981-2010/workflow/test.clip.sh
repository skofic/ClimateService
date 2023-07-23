#!/bin/sh

###
# Convert maps to GeoJSON.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= CONVERT FILES"
echo "=================================================="
start=$(date +%s)

###
# Parameters.
###
name="bio"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/${name}"

echo "--------------------------------------------------"
echo "$name"
echo "--------------------------------------------------"

###
# Convert clipped bioclimatic variables to CSV format.
###
for var in "ai" "bio01"
do
	echo "==> $var"
	gdal2xyz.py -skipnodata -csv "$from/$var.tif" "$dest/$var.csv"
done

###
# Globals.
###
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"

###
# Convert clipped monthly variables to CSV format.
###
for name in "pr" "tas"
echo "--------------------------------------------------"
echo "$name"
echo "--------------------------------------------------"
do
	###
	# Iterate months.
	###
	for month in "01" "02"
	do
		echo "==> $month"
		gdal2xyz.py -skipnodata -csv "$from/${name}_${month}.tif" "$dest/${name}_${month}.csv"
	done
done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= CONVERT FILES: $elapsed seconds"
echo "=================================================="
echo ""
