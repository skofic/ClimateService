#!/bin/sh

###
# Prepare files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/DroughtObservatory/SMA"
start=$(date +%s)

echo "=================================================="
echo "= PREPARE SMA FILES"
echo "=================================================="

# ###
# # Download files.
# ###
# cmd="${epoc}/workflow/download.sh"
# $cmd | tee "${epoc}/log/1_download.log"
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi

###
# Expand and place files.
###
cmd="${epoc}/workflow/expand.sh"
$cmd | tee "${epoc}/log/1_expand.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Convert and place files.
###
cmd="${epoc}/workflow/convert.sh"
$cmd | tee "${epoc}/log/2_convert.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= PREPARE SMA FILES: $elapsed seconds"
echo "=================================================="
echo ""
