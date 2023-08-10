#!/bin/sh

###
# Load map.
#
# This script will iterate all coordinates dumps
# and load the result into the Chelsa map collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection="map_chelsa"
cmd="${path}/Chelsa/script_data/map.sh"

period_1="${path}/Chelsa/1981-2010"
period_2="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
period_3="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
period_4="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

echo "**************************************************"
echo "**************************************************"
echo "*** load_map.sh"
echo "**************************************************"
echo "**************************************************"
LOAD_MAP_START=$(date +%s)

###
# Create periods map.
###
first=1
for period in "$period_1" \
			  "$period_2" \
			  "$period_3" \
			  "$period_4"
do
	set -- $i
	
	###
	# Set parameters.
	###
	file="map"
	epoc="$period"
	dump="${epoc}/data/${file}.jsonl.gz"

	echo ""
	echo "**************************************************"
	echo "*** Load $dump"
	echo "*** into collection $collection"
	if [ $first -ne 0 ]
	then
		echo "*** clearing its contents."
	else
		echo "*** ignoring duplicates."
	fi
	echo "**************************************************"

	###
	# Load to collection.
	# Load period geometries
	# inserting first period and
	# ignoring duplicates for subsequent periods.
	###
	$cmd "$dump" \
		 "$collection" \
		 $first
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	first=0
	
done

LOAD_MAP_END=$(date +%s)
elapsed=$((LOAD_MAP_END-LOAD_MAP_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** load_map.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
