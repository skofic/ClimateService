#!/bin/sh

###
# Download period file.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Parameters.
###
epoc="${path}/WorldClim/2011-2040/MPI-ESM1-2-HR/ssp370"
dict="${path}/WorldClim/config/path_2011_2040.txt"

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
