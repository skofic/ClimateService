#!/bin/sh

###
# Process data.
#
# import GeoJSON data,
# process variables
# and dump to data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
name="elevation"
epoc="${path}/WorldClim/Elevation"

###
# Execute script.
###
cmd="${epoc}/workflow/PROCESS.sh"
$cmd | tee "${epoc}/log/2_PROCESS.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Remove obsolete files.
# We do this here because we assume combining was successful.
###
for folder in "Clipped" "Full"
do
	rm -f "${epoc}/${folder}/${name}.tif"
done

for folder in "CSV"
do
	rm -f "${epoc}/${folder}/${name}.csv.gz"
done
