#!/bin/sh

###
# Create Chelsa database.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Execute script.
###
cmd="${path}/Chelsa/workflow/CREATE.sh"
$cmd | tee "${path}/Chelsa/log/1_CREATE.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
