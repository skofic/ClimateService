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
epoc="${path}/DroughtObservatory"

echo "**************************************************"
echo "**************************************************"
echo "*** create_directories.sh"
echo "**************************************************"
echo "**************************************************"
CREATE_DIRECTORIES_START=$(date +%s)

###
# Create top level folders.
###
mkdir -p "${epoc}/log/"
mkdir -p "${epoc}/data/"

###
# Iterate single level descriptors.
###
for folder in "FAPAN" "FAPAR" "SMA" "SMI" "TWS"
do
	mkdir -p "${epoc}/${folder}/log/"
	mkdir -p "${epoc}/${folder}/download/"
	mkdir -p "${epoc}/${folder}/converted/"
	mkdir -p "${epoc}/${folder}/data/"
	mkdir -p "${epoc}/${folder}/CSV/"
done

###
# Create Heat and Cold Wave Index directories.
###
for folder in "HCWI"
do
	mkdir -p "${epoc}/${folder}/log/"
	for folder in "ano" "max" "min"
	do
		mkdir -p "${epoc}/HCWI/${folder}/download/"
		mkdir -p "${epoc}/HCWI/${folder}/converted/"
		mkdir -p "${epoc}/HCWI/${folder}/data/"
		mkdir -p "${epoc}/HCWI/${folder}/CSV/"
	done
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
