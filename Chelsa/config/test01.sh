#!/bin/sh

###
# Test stuff.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Call script and redirect output.
###
cmd="${path}/Chelsa/config/test02.sh"
$cmd | tee "${path}/Chelsa/1981-2010/log/test.log"
