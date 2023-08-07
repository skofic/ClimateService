#!/bin/sh

###
# Clip map to EUFGIS region.
#
# The script expects the following parameters:
# - $1: Source map full file path.
# - $2: Clipped map full file path.
# - $3: File path to the clip mask.
# - $4: Clip mask layer name.
###

###
# Run warp to clip region.
###
gdalwarp -overwrite -ot UInt16 -of GTiff -tr 0.008333333333333338 -0.008333333333333338 -tap -cutline "$3" -cl "$4" -crop_to_cutline -dstnodata 65535 -multi -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$1" "$2"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
