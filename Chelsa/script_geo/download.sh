#!/bin/sh

###
# Download yearly data files.
#
# The script expects the following parameters:
# - $1: Base directory path to period root.
# - $2: Folder name: bio, pr, tas, tasmax or tasmin.
# - $3: Download files list filename.
#
# Example:
# > download.sh ""
#
# The script will iterate the entries 
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
dest="${1}/Full/${2}"

###
# Iterate list of files.
###
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    url=$(echo $line | cut -d ' ' -f 1)
    name=$(echo $line | cut -d ' ' -f 2)
    
	###
	# Download file.
	###
	wget --continue --output-document="${1}/Full/${2}/${name}" "${url}"
 	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
   
done < "${path}/Chelsa/config/$3"
