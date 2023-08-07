#!/bin/sh

###
# Download zipped files to directory.
#
# This script expects the following parameters:
# - $1: Remote file URL.
# - $2: Destination directory.
# - $3: File name text table full path.
# - $4: Temp file name.
###

###
# Globals.
###
comp="${2}/${4}.zip"

###
# Download zip file.
###
wget --continue "$1" --output-document="$comp"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Unzip file.
###
unzip -o "$comp" -d "$2"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Place files.
###
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    old=$(echo $line | cut -d ' ' -f 1)
    new=$(echo $line | cut -d ' ' -f 2)
    
	###
	# Move file.
	###
	mv -f "${2}/${old}" "${2}/${new}"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
    
done < "$3"

###
# Remove zip file.
###
rm -f "$comp"
