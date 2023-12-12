#!/bin/sh

###
# Create directories.
#
# This script will create all necessary directories.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/RemoteSensing"

echo "**************************************************"
echo "**************************************************"
echo "*** create_directories.sh"
echo "**************************************************"
echo "**************************************************"
CREATE_DIRECTORIES_START=$(date +%s)

###
# Create top level folders.
###
mkdir -p "$expo"
mkdir -p "${epoc}/log/"
mkdir -p "${epoc}/data/"

###
# Iterate single level descriptors.
###
for folder in "fixes"
do
	mkdir -p "${epoc}/${folder}/data/"
done

CREATE_DIRECTORIES_END=$(date +%s)
elapsed=$((CREATE_DIRECTORIES_END-CREATE_DIRECTORIES_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** create_directories.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
