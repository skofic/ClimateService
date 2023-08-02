#!/bin/sh

###
# Clip maps to useful region.
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

echo "--------------------------------------------------"
start=$(date +%s)

###
# Create top level directories.
###
mkdir -p "${path}/WorldClim/log/"

###
# Create elevation directories.
###
mkdir -p "${elevation}/Full/"
mkdir -p "${elevation}/ForgeniusClipped/"
mkdir -p "${elevation}/CSV/"
mkdir -p "${elevation}/data/"
mkdir -p "${elevation}/log/"

###
# Create historical period directories.
###
period="$period_1"

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
mkdir -p "${period}/ForgeniusClipped/bio/"
mkdir -p "${period}/ForgeniusClipped/pr/"
mkdir -p "${period}/ForgeniusClipped/srad/"
mkdir -p "${period}/ForgeniusClipped/tas/"
mkdir -p "${period}/ForgeniusClipped/tasmax/"
mkdir -p "${period}/ForgeniusClipped/tasmin/"
mkdir -p "${period}/ForgeniusClipped/vapr/"
mkdir -p "${period}/ForgeniusClipped/wind/"

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

	###
	# Create full maps directories.
	###
	mkdir -p "${period}/Full/bio/"
	mkdir -p "${period}/Full/pr/"
	mkdir -p "${period}/Full/tasmax/"
	mkdir -p "${period}/Full/tasmin/"

	###
	# Create clipped maps directories.
	###
	mkdir -p "${period}/ForgeniusClipped/bio/"
	mkdir -p "${period}/ForgeniusClipped/pr/"
	mkdir -p "${period}/ForgeniusClipped/tasmax/"
	mkdir -p "${period}/ForgeniusClipped/tasmin/"
	
	###
	# Create CSV directories.
	###
	mkdir -p "${period}/CSV/bio/"
	mkdir -p "${period}/CSV/pr/"
	mkdir -p "${period}/CSV/tasmax/"
	mkdir -p "${period}/CSV/tasmin/"

	###
	# Create data directories.
	###
	mkdir -p "${period}/data/bio/"
	mkdir -p "${period}/data/pr/"
	mkdir -p "${period}/data/tasmax/"
	mkdir -p "${period}/data/tasmin/"
	mkdir -p "${period}/data/properties/"

	###
	# Create other directories.
	###
	mkdir -p "${period}/log/"

done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
