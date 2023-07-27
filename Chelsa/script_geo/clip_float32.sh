#!/bin/sh

###
# Clip map to EUFGIS region and convert values to Float32.
#
# The script expects the following parameters:
# - $1: Source map full file path.
# - $2: Clipped map full file path.
# - $3: Full path to clip region GeoJSON file.
###

###
# Run warp to clip region.
###
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "$3" -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$1" "$2"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
