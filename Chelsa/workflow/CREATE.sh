#!/bin/sh

###
# Create Chelsa database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Create directories.
##
cmd="${path}/Cjelsa/workflow/create_directories.sh"
$cmd

###
# 1981-2010.
###
cmd="${path}/Chelsa/workflow/create_1981_2010.sh"
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
cmd="${path}/Chelsa/workflow/create_2011_2040.sh"
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
cmd="${path}/Chelsa/workflow/create_2041_2070.sh"
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
cmd="${path}/Chelsa/workflow/create_2071_2100.sh"
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
cmd="${path}/Chelsa/workflow/load_periods.sh"
$cmd | tee "${path}/Chelsa/log/load_periods.log"
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
cmd="${path}/Chelsa/workflow/load_map.sh"
$cmd | tee "${path}/Chelsa/log/load_map.log"
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
cmd="${path}/Chelsa/workflow/dump_chelsa.sh"
$cmd | tee "${path}/Chelsa/log/dump_chelsa.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
