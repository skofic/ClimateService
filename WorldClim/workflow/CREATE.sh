#!/bin/sh

###
# Create WorldClim database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
WORLDCLIM=$(date +%s)

###
# Create directories.
##
echo ""
echo "<<< CREATE DIRECTORIES >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_directories.sh"
$cmd

###
# 1981-2010.
###
echo ""
echo "<<< ELEVATION >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_elevation.sh"
$cmd | tee "${path}/WorldClim/log/Elevation.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 1970-2000.
###
echo ""
echo "<<< PERIOD 1970-2000 >>>"
echo ""
cmd="${path}/Chelsa/workflow/create_1970_2000.sh"
$cmd | tee "${path}/Chelsa/log/1970_2000.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

WORLDCLIM_END=$(date +%s)
elapsed=$((WORLDCLIM_END-WORLDCLIM_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> WORLDCLIM.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
