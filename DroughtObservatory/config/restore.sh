#!/bin/sh

###
# Restore download files from backup folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
home="/home/workuser"

echo "--------------------------------------------------"
echo "- RESTORE DOWNLOAD FILES"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate TIF files.
###
for folder in "FAPAN" "FAPAR" "CDI" "SMA" "SMI" "TWS"
do
	
	###
	# Set path.
	###
	epoc="${path}/DroughtObservatory/${folder}"
	
	###
	# Create download folder.
	###
	mkdir -p "${epoc}/download"
	
	###
	# Empty download folder.
	###
	rm -f "${epoc}/download"/*
	
	###
	# Iterate files.
	###
	for file in "${home}/Backup/DroughtObservatory/${folder}/*.zip"
	do
	
		###
		# Copy files to download folder.
		###
		cp -f "$file" "${epoc}/download/"

	done
	
done