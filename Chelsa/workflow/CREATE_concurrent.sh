#!/bin/sh

###
# Create Chelsa database.
# Concurrent version.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
CHELSA=$(date +%s)

###
# Create directories.
##
echo ""
echo "<<< CREATE DIRECTORIES >>>"
echo ""
cmd="${path}/Chelsa/workflow/create_directories.sh"
$cmd

###
# 1981-2010.
###
echo ""
echo "<<< PERIOD 1981-2010 >>>"
echo ""
cmd="${path}/Chelsa/workflow/create_1981_2010_concurrent.sh"
$cmd | tee "${path}/Chelsa/log/1981_2010.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2011-2040.
###
echo ""
echo "<<< PERIOD 2011-2040 >>>"
echo ""
cmd="${path}/Chelsa/workflow/create_2011_2040_concurrent.sh"
$cmd | tee "${path}/Chelsa/log/2011_2040.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2041-2070.
###
echo ""
echo "<<< PERIOD 2041-2070 >>>"
echo ""
cmd="${path}/Chelsa/workflow/create_2041_2070_concurrent.sh"
$cmd | tee "${path}/Chelsa/log/2041_2070.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# 2071-2100.
###
echo ""
echo "<<< PERIOD 2071-2100 >>>"
echo ""
cmd="${path}/Chelsa/workflow/create_2071_2100_concurrent.sh"
$cmd | tee "${path}/Chelsa/log/2071_2100.log"
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
cmd="${path}/Chelsa/workflow/load_periods.sh"
$cmd | tee "${path}/Chelsa/log/FINALISE_1_load_periods.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Load coordinate dumps into Chelsa map collection.
###
echo ""
echo "<<< LOAD COORDINATES INTO DATABASE >>>"
echo ""
cmd="${path}/Chelsa/workflow/load_map.sh"
$cmd | tee "${path}/Chelsa/log/FINALISE_2_load_map.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Dump Chelsa and dump Chelsa map.
###
echo ""
echo "<<< DUMP AND LOAD IN DATABASE >>>"
echo ""
cmd="${path}/Chelsa/workflow/dump_chelsa.sh"
$cmd | tee "${path}/Chelsa/log/FINALISE_3_dump_chelsa.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

CHELSA_END=$(date +%s)
elapsed=$((CHELSA_END-CHELSA_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> CHELSA.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
