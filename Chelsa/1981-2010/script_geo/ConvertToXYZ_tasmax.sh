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
name="tasmax"
epoc="$path/Chelsa/1981-2010"
from="${epoc}/ForgeniusClipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped maximum temperature variables to CSV format.
###
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do

	###
	# Convert to CSV.
	###
	gdal2xyz.py -skipnodata -csv "$from/${name}_${month}.tif" "$dest/${name}_${month}.csv"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Compress file.
	###
	echo "=> Compress..."
	gzip "$dest/${name}_${month}.csv"
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
