#!/bin/sh

###
# Check configuration file values.
#
# This script will display the conficuration file values.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Display.
###
echo "--------------------------------------------------"
echo "- CONFIGURATION FILE VALUES"
echo "--------------------------------------------------"
echo "Configuration file path: ${HOME}/.ClimateService"
echo "--------------------------------------------------"
echo "Database name (base):                $base"
echo "Database host (host):                $host"
echo "Database user (user):                $user"
echo "Database pass (pass):                $pass"
echo "Climate service path (path):         $path"
echo "Clip mask shape file path (poly):    $poly"
echo "Export folder path (expo):           $expo"
echo "Clip mask layer name (pnam):         $pnam"
echo "Common variable names prefix (pref): $pref"
echo "--------------------------------------------------"
