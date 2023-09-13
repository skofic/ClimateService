#!/bin/sh

###
# Create Global Drought Observatory database.
# Concurrent version.
###

echo "=================================================="
echo "= CREATE_consurrent.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
CREATE_concurrent_START=$(date +%s)

###
# Load default parameters.
###
source "${HOME}/.ClimateService"
epoc="${path}/GlobalDroughtObservatory"

# ###
# # Create directories.
# ##
# echo ""
# echo "<<< CREATE DIRECTORIES >>>"
# echo ""
# cmd="${epoc}/workflow/create_directories.sh"
# $cmd | tee "${epoc}/log/0_create_directories.log"

# ###
# # Prepare files.
# ###
# echo ""
# echo "<<< PREPARE FILES >>>"
# echo ""
# cmd="${epoc}/workflow/prepare.sh"
# $cmd | tee "${epoc}/log/1_prepare_concurrent.log"
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi

###
# Process files.
###
echo ""
echo "<<< PROCESS FILES >>>"
echo ""
cmd="${epoc}/workflow/process.sh"
$cmd | tee "${epoc}/log/2_process.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

CREATE_concurrent_END=$(date +%s)
elapsed=$((CREATE_concurrent_END-CREATE_concurrent_TART))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> CREATE_consurrent.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
