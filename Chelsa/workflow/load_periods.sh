#!/bin/sh

###
# Load periods.
#
# This script will load all periods into their respective collections
# and it will dump all period coordinates into a file in the respective data folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
file="properties"
period_1="${path}/Chelsa/1981-2010"
collection_1="temp_period_1"
period_2="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
collection_2="temp_period_2"
period_3="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
collection_3="temp_period_3"
period_4="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
collection_4="temp_period_4"

echo "**************************************************"
echo "**************************************************"
echo "*** load_periods.sh"
echo "**************************************************"
echo "**************************************************"
LOAD_PERIODS_START=$(date +%s)

###
# Create period directories.
###
first=1
for number in "1" "2" "3" "4"
do
	###
	# Set run parameters.
	###
	period="period_${number}"
	collection="collection_${number}"

	###
	# Set parameters.
	###
	epoc="${!period}"
	coll="${!collection}"
	dump="${epoc}/${file}.jsonl.gz"
	save="${epoc}/data/properties/map.jsonl.gz"

	echo ""
	echo "**************************************************"
	echo "*** $coll"
	echo "*** $dump"
	echo "**************************************************"

	###
	# Load to collection.
	###
	cmd="${path}/Chelsa/script_data/load.sh"
	$cmd "${epoc}/properties.jsonl.gz" "$coll"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi

	###
	# Dump to map.
	###
	cmd="${path}/Chelsa/script_data/dump.sh"
	$cmd "$save" \
		"${path}/Chelsa/script_query/export_points.aql" \
		"{\"@@collection\": \"$coll\"}"
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
