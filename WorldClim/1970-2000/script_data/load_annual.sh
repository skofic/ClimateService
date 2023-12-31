#!/bin/sh

###
# Load bioclimatic data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Load annual data."
echo "====================================================================="

###
# Globals.
###
coll="temp_annual"
file="combined_annual"
epoc="${path}/WorldClim/1970-2000"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Load ${dump}"
start=$(date +%s)

###
# Import data from JSONL file.
###
cmd="${path}/WorldClim/script_data/load.sh"
$cmd "$dump" "$coll"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
		
end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "1970-2000 load_annual.sh"
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
