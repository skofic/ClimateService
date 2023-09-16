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
# Delete ignored folders.
###
rm -rf "${path}/DroughtObservatory/log"

###
# Iterate folders.
###
for folder in "FAPAN" "FAPAR" "CDI" "SMA" "SMI" "TWS"
do
	
	###
	# Set path.
	###
	epoc="${path}/DroughtObservatory/${folder}"
	
	###
	# Delete ignored folders.
	###
	rm -rf "${epoc}/converted"
	rm -rf "${epoc}/CSV"
	rm -rf "${epoc}/data"
	rm -rf "${epoc}/download"
	rm -rf "${epoc}/log"
	
	###
	# Create ignored folders.
	###
	mkdir -p "${epoc}/download"
	
	###
	# Iterate files.
	###
	for file in "${home}/Backup/DroughtObservatory/${folder}/"*.zip
	do
	
		###
		# Copy files to download folder.
		###
		cp -f "$file" "${epoc}/download/"

	done
	
done

###
# Create ignored folders.
###
rmkdir -p "${path}/DroughtObservatory/log"

###
# Iterate HCWI.
###
for folder in "HCWI"
do
	
	###
	# Delete ignored folders.
	###
	rm -rf "${path}/DroughtObservatory/${folder}/log"

	###
	# Iterate subfolders.
	###
	for sub in "ano" "day" "max" "min"
	do
	
		###
		# Set path.
		###
		epoc="${path}/DroughtObservatory/${folder}/${sub}"
	
		###
		# Delete ignored folders.
		###
		rm -rf "${epoc}/converted"
		rm -rf "${epoc}/CSV"
		rm -rf "${epoc}/data"
		rm -rf "${epoc}/download"
	
		###
		# Create ignored folders.
		###
		mkdir -p "${epoc}/download"
	
		###
		# Iterate files.
		###
		for file in "${home}/Backup/DroughtObservatory/${folder}/${sub}/"*.zip
		do
	
			###
			# Copy files to download folder.
			###
			cp -f "$file" "${epoc}/download/"

		done
	
	done

	###
	# Create ignored folders.
	###
	rmkdir -p "${path}/DroughtObservatory/${folder}/log"
	
done
