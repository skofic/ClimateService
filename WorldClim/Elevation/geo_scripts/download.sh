#!/bin/sh

###
# Download elevation file.
###

###
# Globals.
###
name="wc2.1_30s_elev"
path="/home/workuser/ClimateService"
remo="https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/${name}.zip"
dest="${path}/WorldClim/Elevation/Full"

###
# Download.
###

echo "--------------------------------------------------"
start=$(date +%s)

###
# Get files.
###
wget --continue --force-directories --output-document="$dest/${name}.zip" "$remo"

###
# Expand files.
###
unzip -o "$dest/${name}.zip" -d "$dest"

###
# remove zip files.
###
rm "$dest/${name}.zip"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
