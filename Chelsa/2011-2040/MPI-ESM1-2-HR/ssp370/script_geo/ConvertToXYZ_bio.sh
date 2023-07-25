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
name="bio"
epoc="$path/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
from="${epoc}/ForgeniusClipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped bioclimatic variables to CSV format.
###
for var in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "fcf" "fgd" "gdd0" "gdd10" "gdd5" "gddlgd0" "gddlgd10" "gddlgd5" "gdgfgd0" "gdgfgd10" "gdgfgd5" "gsl" "gsp" "gst" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd10" "ngd5" "npp" "scd" "swe"
do

	###
	# Convert to CSV.
	###
	gdal2xyz.py -skipnodata -csv "$from/$var.tif" "$dest/$var.csv"
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
	gzip "$dest/$var.csv"
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
