#!/bin/sh

###
# Create directories.
#
# This script will create all necessary directories.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
period_1="${path}/Chelsa/1981-2010"
period_2="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
period_3="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
period_4="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

echo "**************************************************"
echo "**************************************************"
echo "*** create_directories.sh"
echo "**************************************************"
echo "**************************************************"
CREATE_START=$(date +%s)

###
# Create top level log folder,
###
mkdir -p "${path}/Chelsa/log/"
mkdir -p "${path}/Chelsa/data/"

###
# Create period directories.
###
for period in "$period_1" "$period_2" "$period_3" "$period_4"
do

	echo ""
	echo "**************************************************"
	echo "*** $period"
	echo "**************************************************"

	###
	# Create CSV directories.
	###
	mkdir -p "${period}/CSV/"
	mkdir -p "${period}/CSV/bio/"
	mkdir -p "${period}/CSV/pr/"
	mkdir -p "${period}/CSV/tas/"
	mkdir -p "${period}/CSV/tasmax/"
	mkdir -p "${period}/CSV/tasmin/"

	###
	# Create data directories.
	###
	mkdir -p "${period}/data/"
	mkdir -p "${period}/data/bio/"
	mkdir -p "${period}/data/pr/"
	mkdir -p "${period}/data/tas/"
	mkdir -p "${period}/data/tasmax/"
	mkdir -p "${period}/data/tasmin/"
	mkdir -p "${period}/data/properties/"

	###
	# Create clipped directories.
	###
	mkdir -p "${period}/Clipped/"
	mkdir -p "${period}/Clipped/bio/"
	mkdir -p "${period}/Clipped/pr/"
	mkdir -p "${period}/Clipped/tas/"
	mkdir -p "${period}/Clipped/tasmax/"
	mkdir -p "${period}/Clipped/tasmin/"

	###
	# Create clipped directories.
	###
	mkdir -p "${period}/Full/"
	mkdir -p "${period}/Full/bio/"
	mkdir -p "${period}/Full/pr/"
	mkdir -p "${period}/Full/tas/"
	mkdir -p "${period}/Full/tasmax/"
	mkdir -p "${period}/Full/tasmin/"

	###
	# Create other directories.
	###
	mkdir -p "${period}/log/"
	
done

CREATE_END=$(date +%s)
elapsed=$((CREATE_END-CREATE_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** create_directories.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
