#!/bin/sh

###
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

###
# Test.
###
echo "Conf: $conf"
echo "Path: $path"
echo "User: $user"
echo "Pass: $pass"
