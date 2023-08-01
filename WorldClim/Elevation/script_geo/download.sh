#!/bin/sh

###
# Download elevation files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Parameters.
###
name="elev"
epoc="${path}/WorldClim/Elevation"
dest="${epoc}/Full"
dict="${path}/WorldClim/config/path_elevation.txt"
remo="https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_elev.zip"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Download and place files.
###
cmd="${path}/WorldClim/script_geo/download.sh"
$cmd	"$remo" \
		"$dest" \
		"$dict" \
		"$name"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
