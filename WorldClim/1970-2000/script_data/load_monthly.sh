#!/bin/sh

###
# Load monthly data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Load monthly data."
echo "====================================================================="

###
# Globals.
###
coll="temp_monthly"
file="combined_monthly"
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
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
