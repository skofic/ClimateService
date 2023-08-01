#!/bin/sh

###
# Stack coordinates to provided collection.
#
# The script expects the following parameters:
# - $1: Full file path of dump to import.
# - $2: Name of collection into which to write.
# - $3: First run flag: 1 (first run) or 0.
#
# The goal of this step is to combine all coordinates
# from different periods into the map collection.
#
# The second parameter indicates
# whether the collection should be cleared.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Import file into database.
###
if [ $3 -eq 1 ]
then
	arangoimport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--file "$1" \
		--type "jsonl" \
		--collection "$2" \
		--auto-rate-limit true \
		--ignore-missing \
		--overwrite
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
else
	arangoimport \
		--server.endpoint "$host" \
		--server.database "$base" \
		--server.username "$user" \
		--server.password "$pass" \
		--file "$1" \
		--type "jsonl" \
		--collection "$2" \
		--auto-rate-limit true \
		--ignore-missing
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
fi
