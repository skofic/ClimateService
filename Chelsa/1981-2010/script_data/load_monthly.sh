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
start=$(date +%s)

###
# Globals.
###
coll="temp_monthly"
file="combined_monthly"
epoc="$path/Chelsa/1981-2010"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Load ${dump}"

###
# Import data from JSONL file.
###
cmd="${path}/Chelsa/script_data/load.sh"
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
echo "1981-2010 load_monthly.sh"
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
