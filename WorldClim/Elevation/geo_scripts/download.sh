#!/bin/sh

###
# Download elevation file.
###

###
# Globals.
###
path="/home/workuser"
file="https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_elev.zip"
dest="${path}/WorldClim/Elevation/Full/elev.zip"

###
# Download.
###

echo "--------------------------------------------------"
start=$(date +%s)

###
# Get files.
###
wget "$file" --force-directories --output-document="$dest"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
