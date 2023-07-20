#!/bin/sh

###
# Clip maps to useful region.
###

###
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

###
# Globals.
###
name="tas"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"
cmd="gdal2xyz.py"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped average temperature variables to CSV format.
###
for month in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
do
	gdal2xyz.py -skipnodata -csv "$from/${name}_${month}.tif" "$dest/${name}_${month}.csv"
done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
