#!/bin/sh

###
# Dump data coordinates.
#
# It will dump the geometries of annual and
# monthly data to their respective dump files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Dump coordinates"
echo "====================================================================="

###
# Globals.
###
cmd="${path}/Chelsa/script_data/dump.sh"
epoc="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
query="${path}/Chelsa/script_query/export_points.aql"

###
# Parameters.
###
coll="temp_annual"
file="coordinates_annual"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Dump ${dump}"
start=$(date +%s)

###
# Export annual coordinates.
###
$cmd "$dump" \
	 "$query" \
	 "{\"@@collection\": \"$coll\"}"
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
echo "2011-2040 dump_coordinates.sh (annual)"
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"

###
# Parameters.
###
coll="temp_monthly"
file="coordinates_monthly"
dump="${epoc}/data/properties/${file}.jsonl.gz"

echo "----------------------------------------"
echo "==> Dump ${dump}"
start=$(date +%s)

###
# Export monthly coordinates.
###
$cmd "$dump" \
	 "$query" \
	 "{\"@@collection\": \"$coll\"}"
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
echo "2011-2040 dump_coordinates.sh (monthly)"
echo "Elapsed time: $elapsed seconds"
echo "----------------------------------------"
