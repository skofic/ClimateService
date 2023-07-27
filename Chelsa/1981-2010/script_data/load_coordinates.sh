#!/bin/sh

###
# Load coordinates in collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
coll="temp_pong"
epoc="$path/Chelsa/1981-2010"

echo "----------------------------------------"
echo "==> Load ${coll}"
start=$(date +%s)

###
# Import bioclimatic coordinates from JSONL file.
# Note that here we use the temp_pong collection and we clear it,
# a good thing, since it is holding more than 2 billion records...
###
file="coordinates_annual"
cmd="${path}/Chelsa/script_data/load.sh"
$cmd "${epoc}/data/properties/${file}.jsonl.gz" \
	 "$coll"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Import monthly coordinates from JSONL file.
###
file="coordinates_monthly"
cmd="${path}/Chelsa/script_data/load_ignore.sh"
$cmd "${epoc}/data/properties/${file}.jsonl.gz" \
	 "$coll"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
