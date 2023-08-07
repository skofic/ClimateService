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
period_1="${path}/WorldClim/1970-2000"
period_2="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"
period_3="${path}/WorldClim/2041-2060/MPI-ESM1-2-HR/ssp370"
period_4="${path}/WorldClim/2061-2080/MPI-ESM1-2-HR/ssp370"
period_5="${path}/WorldClim/2081-2100/MPI-ESM1-2-HR/ssp370"
elevation="${path}/WorldClim/Elevation"

echo "**************************************************"
echo "**************************************************"
echo "*** create_directories.sh"
echo "**************************************************"
echo "**************************************************"
CREATE_START=$(date +%s)

###
# Create top level log folder,
###
mkdir -p "${path}/WorldClim/log/"

###
# Create elevation directories.
###
mkdir -p "${elevation}/Full/"
mkdir -p "${elevation}/Clipped/"
mkdir -p "${elevation}/CSV/"
mkdir -p "${elevation}/data/"
mkdir -p "${elevation}/log/"

###
# Create historical period directories.
###
period="$period_1"

echo ""
echo "**************************************************"
echo "*** $period"
echo "**************************************************"

###
# Create full maps directories.
###
mkdir -p "${period}/Full/bio/"
mkdir -p "${period}/Full/pr/"
mkdir -p "${period}/Full/srad/"
mkdir -p "${period}/Full/tas/"
mkdir -p "${period}/Full/tasmax/"
mkdir -p "${period}/Full/tasmin/"
mkdir -p "${period}/Full/vapr/"
mkdir -p "${period}/Full/wind/"

###
# Create clipped maps directories.
###
mkdir -p "${period}/Clipped/bio/"
mkdir -p "${period}/Clipped/pr/"
mkdir -p "${period}/Clipped/srad/"
mkdir -p "${period}/Clipped/tas/"
mkdir -p "${period}/Clipped/tasmax/"
mkdir -p "${period}/Clipped/tasmin/"
mkdir -p "${period}/Clipped/vapr/"
mkdir -p "${period}/Clipped/wind/"

###
# Create CSV directories.
###
mkdir -p "${period}/CSV/bio/"
mkdir -p "${period}/CSV/pr/"
mkdir -p "${period}/CSV/srad/"
mkdir -p "${period}/CSV/tas/"
mkdir -p "${period}/CSV/tasmax/"
mkdir -p "${period}/CSV/tasmin/"
mkdir -p "${period}/CSV/vapr/"
mkdir -p "${period}/CSV/wind/"

###
# Create data directories.
###
mkdir -p "${period}/data/bio/"
mkdir -p "${period}/data/pr/"
mkdir -p "${period}/data/srad/"
mkdir -p "${period}/data/tas/"
mkdir -p "${period}/data/tasmax/"
mkdir -p "${period}/data/tasmin/"
mkdir -p "${period}/data/vapr/"
mkdir -p "${period}/data/wind/"
mkdir -p "${period}/data/properties/"

###
# Create other directories.
###
mkdir -p "${period}/log/"

###
# Create future period directories.
###
for period in "$period_2" "$period_3" "$period_4" "$period_5"
do

	echo ""
	echo "**************************************************"
	echo "*** $period"
	echo "**************************************************"

	###
	# Create top level directories.
	###
	mkdir -p "${period}/Full/"
	mkdir -p "${period}/Clipped/"
	mkdir -p "${period}/CSV/"
	mkdir -p "${period}/data/"

	###
	# Create data properties directory.
	###
	mkdir -p "${period}/data/properties/"

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
