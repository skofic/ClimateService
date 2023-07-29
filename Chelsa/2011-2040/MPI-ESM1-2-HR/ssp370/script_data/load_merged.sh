#!/bin/sh

###
# Load merged data.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Load merged data."
echo "====================================================================="

###
# Globals.
###
file="properties"
coll="temp_period_1"
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
dump="${epoc}/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Load ${dump}"
start=$(date +%s)

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
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
