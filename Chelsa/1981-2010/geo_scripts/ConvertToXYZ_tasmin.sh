#!/bin/sh

###
# Clip maps to useful region.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
name="tasmin"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/${name}"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped minimum temperature variables to CSV format.
###
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do

	###
	# Convert to CSV.
	###
	gdal2xyz.py -skipnodata -csv "$from/${name}_${month}.tif" "$dest/${name}_${month}.csv"
	
	###
	# Compress file.
	###
	echo "=> Compress..."
	gzip "$dest/${name}_${month}.csv"
	
done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
