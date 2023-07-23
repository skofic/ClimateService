#!/bin/sh

###
# Process all bioclimatic variables.
#
# Will iterate all bioclimatic data files,
# normalising the value according to Chelsa instructions
# and generating a compressed CSV file
# moving it in its directory.
#
# This is the first step in the PREPARE workflow.
###

###
# Find default parameters.
###
conf="${HOME}/.ClimateService"

###
# Load default parameters.
###
source "$conf"

###
# Globals.
###
echo "HOST: $host"
echo "USER: $user"
echo "PASS: $pass"
echo "PATH: $path"
echo "PREF: $pref"
