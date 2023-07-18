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
name="pr"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped precipitation variables to CSV format.
###
gdal2xyz.py -skipnodata -csv "$from/pr_01.tif" "$dest/pr_01.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_02.tif" "$dest/pr_02.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_03.tif" "$dest/pr_03.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_04.tif" "$dest/pr_04.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_05.tif" "$dest/pr_05.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_06.tif" "$dest/pr_06.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_07.tif" "$dest/pr_07.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_08.tif" "$dest/pr_08.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_09.tif" "$dest/pr_09.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_10.tif" "$dest/pr_10.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_11.tif" "$dest/pr_11.csv"
gdal2xyz.py -skipnodata -csv "$from/pr_12.tif" "$dest/pr_12.csv"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
