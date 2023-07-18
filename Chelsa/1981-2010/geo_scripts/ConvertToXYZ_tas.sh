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
name="tas"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped average temperature variables to CSV format.
###
gdal2xyz.py -skipnodata -csv "$from/tas_01.tif" "$dest/tas_01.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_02.tif" "$dest/tas_02.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_03.tif" "$dest/tas_03.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_04.tif" "$dest/tas_04.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_05.tif" "$dest/tas_05.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_06.tif" "$dest/tas_06.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_07.tif" "$dest/tas_07.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_08.tif" "$dest/tas_08.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_09.tif" "$dest/tas_09.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_10.tif" "$dest/tas_10.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_11.tif" "$dest/tas_11.csv"
gdal2xyz.py -skipnodata -csv "$from/tas_12.tif" "$dest/tas_12.csv"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
