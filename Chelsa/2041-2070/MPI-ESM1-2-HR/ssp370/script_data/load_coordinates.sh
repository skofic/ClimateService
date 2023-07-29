#!/bin/sh

###
# Load coordinates in collection.
#
# When done, temp_pong will contain
# the coordinates for the current period.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Load coordinates."
echo "====================================================================="

###
# Globals.
###
coll="temp_pong"
epoc="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"

###
# Properties.
###
file="coordinates_annual"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Load ${dump}"
start=$(date +%s)

###
# Import yearly coordinates from JSONL file.
# Note that here we use the temp_pong collection and we clear it,
# a good thing, since it is holding more than 2 billion records...
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

###
# Properties.
###
file="coordinates_monthly"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Load ${dump}"
start=$(date +%s)

###
# Import monthly coordinates from JSONL file.
###
cmd="${path}/Chelsa/script_data/load_ignore.sh"
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
