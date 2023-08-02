#!/bin/sh

###
# Convert map from .tif to .csv, without header line.
#
# The script expects the following parameters:
# - $1: Source map full file path.
# - $2: Converted document full file path (must end in .csv).
###

###
# Convert to CSV.
###
gdal2xyz.py -skipnodata -csv "$1" "$2"
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
gzip -f "$2"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
