#!/bin/sh

###
# Download precipitation files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Parameters.
###
name="pr"
epoc="${path}/WorldClim/1970-2000"
dest="${epoc}/Full"
dict="${path}/WorldClim/config/path_1970_2000_pr.txt"
remo="https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_prec.zip"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Download and place files.
###
cmd="${path}/WorldClim/script_geo/download_folder_zip.sh"
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
echo "--------------------------------------------------"
echo "1970-2000 download_pr.sh"
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
