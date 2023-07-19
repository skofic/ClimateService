#!/bin/sh

###
# Download and clip maps.
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

echo "=================================================="
echo "PREPARE BIOCLIMATIC FILES"
echo "=================================================="
start=$(date +%s)

echo "**************************************************"
echo "DOWNLOAD FILES"
echo "**************************************************"
cmd="${path}/Chelsa/1981-2010/geo_scripts/download_bio.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/download_pr.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/download_tas.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/download_tasmax.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/download_tasmin.sh"
$cmd < "${path}/config.txt"

echo ""
echo "**************************************************"
echo "CLIP FILES"
echo "**************************************************"
cmd="${path}/Chelsa/1981-2010/geo_scripts/ClipToForgeniusMask_bio.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/ClipToForgeniusMask_pr.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/ClipToForgeniusMask_tas.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/ClipToForgeniusMask_tasmax.sh"
$cmd < "${path}/config.txt"
cmd="${path}/Chelsa/1981-2010/geo_scripts/ClipToForgeniusMask_tasmin.sh"
$cmd < "${path}/config.txt"

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "PREPARE BIOCLIMATIC FILES: $elapsed seconds"
echo "=================================================="
echo ""
