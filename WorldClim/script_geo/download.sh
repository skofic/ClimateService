#!/bin/sh

###
# Download and place file.
#
# The script expects the following parameters:
# - $1: Download URL.
# - $2: Destination file path.
###

###
# Download file.
###
wget --continue --output-document="$2" "$1"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
