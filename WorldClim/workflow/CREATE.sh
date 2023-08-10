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
cmd="${path}/WorldClim/workflow/create_1970_2000.sh"
$cmd | tee "${path}/WorldClim/log/1970_2000.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2021-2040.
###
echo ""
echo "<<< PERIOD 2021-2040 >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_2021_2040.sh"
$cmd | tee "${path}/WorldClim/log/2021_2040.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2061-2080.
###
echo ""
echo "<<< PERIOD 2061-2080 >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_2061_2080.sh"
$cmd | tee "${path}/WorldClim/log/2061_2080.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2081-2100.
###
echo ""
echo "<<< PERIOD 2081-2100 >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_2081_2100.sh"
$cmd | tee "${path}/WorldClim/log/2081_2100.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Load dumps into temporary period collections
# and dump periods coordinates.
###
echo ""
echo "<<< LOAD PERIOD DUMPS INTO DATABASE >>>"
echo ""
cmd="${path}/WorldClim/workflow/load_periods.sh"
$cmd | tee "${path}/WorldClim/log/load_periods.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Load coordinate dumps into map collection.
###
echo ""
echo "<<< LOAD COORDINATES INTO DATABASE >>>"
echo ""
cmd="${path}/WorldClim/workflow/load_map.sh"
$cmd | tee "${path}/WorldClim/log/load_map.log"
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
