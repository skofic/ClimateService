#!/bin/sh

###
# Create Worldclim period data.
#
# This script will create everything, it is supposed to be run
# just after cloning the git repository.
#
# Be aware that this involves downloading more than 200GB. of data
# and processing over 8 billion records: this means that the whole
# process will probably take more than a week, or even much more,
# depending on the computer that runs it.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/WorldClim/1970-2000"

echo "**************************************************"
echo "**************************************************"
echo "*** create_1970_2000_concurrent.sh"
echo "**************************************************"
echo "**************************************************"
CREATE_1970_2000_START=$(date +%s)

###
# Create logs directory and remove eventual existing logs.
###
mkdir -p "${epoc}/log"

###
# Prepare data.
###
cmd="${epoc}/workflow/1_PREPARE_concurrent.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Process data.
###
cmd="${epoc}/workflow/2_PROCESS.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Combine annual data.
###
cmd="${epoc}/workflow/3_COMBINE_ANNUAL.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Combine monthly data.
###
cmd="${epoc}/workflow/4_COMBINE_MONTHLY.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Merge data.
###
cmd="${epoc}/workflow/5_MERGE.sh"
$cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

CREATE_1970_2000_END=$(date +%s)
elapsed=$((CREATE_1970_2000_END-CREATE_1970_2000_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** create_1970_2000_concurrent.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
