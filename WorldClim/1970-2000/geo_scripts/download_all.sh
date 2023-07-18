#!/bin/sh

###
# Download all files.
###

###
# Globals.
###
path="/home/workuser"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

###
# Download.
###

echo "====================================================================="
echo "= Download all Worldclim files."
echo "====================================================================="

echo "--------------------------------------------------"
start=$(date +%s)

###
# Get files.
###
wget "https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_elev.zip" --output-document="${path}/WorldClim/Elevation/Full/elev.zip"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
