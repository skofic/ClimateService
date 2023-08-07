#!/bin/sh

###
# Download period file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
peri="2021_2040"
epoc="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
dict="${path}/WorldClim/config/path_${peri}.txt"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Download and place files.
###
cmd="${path}/WorldClim/script_geo/download.sh"
$cmd	"$epoc" \
		"$dict"
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
