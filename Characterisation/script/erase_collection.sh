#!/bin/sh

###
# ERASE COLLECTION.
#
# The script expects the following parameters:
# - $1: Collection name.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Parameters.
###
dump="${path}/Characterisation/config/empty.json"

###
# Import an empty file.
###
arangoimport \
	--server.endpoint "$host" \
	--server.database "$base" \
	--server.username "$user" \
	--server.password "$pass" \
	--file "$dump" \
	--type "json" \
	--collection "$1" \
	--overwrite
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
