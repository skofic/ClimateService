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
name="tasmin"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped minimum temperature variables to CSV format.
###
gdal2xyz.py -skipnodata -csv "$from/tasmin_01.tif" "$dest/tasmin_01.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_02.tif" "$dest/tasmin_02.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_03.tif" "$dest/tasmin_03.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_04.tif" "$dest/tasmin_04.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_05.tif" "$dest/tasmin_05.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_06.tif" "$dest/tasmin_06.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_07.tif" "$dest/tasmin_07.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_08.tif" "$dest/tasmin_08.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_09.tif" "$dest/tasmin_09.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_10.tif" "$dest/tasmin_10.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_11.tif" "$dest/tasmin_11.csv"
gdal2xyz.py -skipnodata -csv "$from/tasmin_12.tif" "$dest/tasmin_12.csv"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
