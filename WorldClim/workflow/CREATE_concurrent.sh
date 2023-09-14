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
# ELEVATION.
###
echo ""
echo "<<< ELEVATION >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_elevation.sh"
$cmd | tee "${path}/WorldClim/log/1_Elevation.log"
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
cmd="${path}/WorldClim/workflow/create_1970_2000_concurrent.sh"
$cmd | tee "${path}/WorldClim/log/2_1970_2000_concurrent.log"
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
cmd="${path}/WorldClim/workflow/create_2021_2040_concurrent.sh"
$cmd | tee "${path}/WorldClim/log/3_2021_2040_concurrent.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2041-2060.
###
echo ""
echo "<<< PERIOD 2041-2060 >>>"
echo ""
cmd="${path}/WorldClim/workflow/create_2041_2060_concurrent.sh"
$cmd | tee "${path}/WorldClim/log/4_2041_2060_concurrent.log"
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
cmd="${path}/WorldClim/workflow/create_2061_2080_concurrent.sh"
$cmd | tee "${path}/WorldClim/log/5_2061_2080_concurrent.log"
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
cmd="${path}/WorldClim/workflow/create_2081_2100_concurrent.sh"
$cmd | tee "${path}/WorldClim/log/6_2081_2100_concurrent.log"
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
$cmd | tee "${path}/WorldClim/log/7_load_periods.log"
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
$cmd | tee "${path}/WorldClim/log/8_load_map.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Dump Chelsa and dump map.
###
echo ""
echo "<<< DUMP AND LOAD IN DATABASE >>>"
echo ""
cmd="${path}/WorldClim/workflow/dump_worldclim.sh"
$cmd | tee "${path}/WorldClim/log/9_dump_worldclim.log"
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
