#!/bin/sh

###
# Clip maps to useful region.
###

###
# Parameters.
###
read arg
user="$arg"
read arg
pass="$arg"
read arg
path="$arg"

###
# Globals.
###
name="tasmax"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped maximum temperature variables to CSV format.
###
gdal2xyz.py -skipnodata -csv "$from/tasmax_01.tif" "$dest/tasmax_01.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_02.tif" "$dest/tasmax_02.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_03.tif" "$dest/tasmax_03.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_04.tif" "$dest/tasmax_04.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_05.tif" "$dest/tasmax_05.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_06.tif" "$dest/tasmax_06.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_07.tif" "$dest/tasmax_07.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_08.tif" "$dest/tasmax_08.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_09.tif" "$dest/tasmax_09.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_10.tif" "$dest/tasmax_10.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_11.tif" "$dest/tasmax_11.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmax_12.tif" "$dest/tasmax_12.csv"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
