#!/bin/sh

###
# Load bioclimatic data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
coll="temp_annual"
file="combined_annual"
epoc="$path/Chelsa/1981-2010"

###
# Import data from JSONL file.
###
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
		
end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
