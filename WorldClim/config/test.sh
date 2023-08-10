#!/bin/sh

###
# Load periods.
#
# This script will load all periods into their respective collections.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
file="properties"
cmd="${path}/WorldClim/script_data/load.sh"

collection_0="temp_period_0"
collection_1="temp_period_1"
collection_2="temp_period_2"
# collection_3="temp_period_3"
# collection_4="temp_period_4"
# collection_4="temp_period_5"

period_0="${path}/WorldClim/Elevation"
period_1="${path}/WorldClim/1970-2000"
period_2="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"
# period_3="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"
# period_4="${path}/WorldClim/2061-2080/MPI-ESM1-2-HR/ssp370"
# period_5="${path}/WorldClim/2081-2100/MPI-ESM1-2-HR/ssp370"

echo "**************************************************"
echo "**************************************************"
echo "*** load_periods.sh"
echo "**************************************************"
echo "**************************************************"
LOAD_PERIODS_START=$(date +%s)

###
# Iterate periods.
###
first=1
for i in "${collection_0} ${period_0}" \
         "${collection_1} ${period_1}" \
         "${collection_2} ${period_2}"
do
	
	set -- $i

	###
	# Set parameters.
	###
	epoc="$2"
	coll="$1"
	dump="${epoc}/data/${file}.jsonl.gz"

	echo ""
	echo "**************************************************"
	echo "*** Load $dump"
	echo "*** into collection $coll"
	echo "**************************************************"

	###
	# Load to collection.
	# Load period dump files into related collection.
	###
	$cmd "$dump" "$coll"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
done

LOAD_PERIODS_END=$(date +%s)
elapsed=$((LOAD_PERIODS_END-LOAD_PERIODS_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** load_periods.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
