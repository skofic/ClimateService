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

echo "--------------------------------------------------"
start=$(date +%s)

###
# Create period directories.
###
for period in period_1 period_2 period_3 period_4 period_5
do

	###
	# Create CSV directories.
	###
	mkdir "${period}/CSV/"
	mkdir "${period}/CSV/bio/"
	mkdir "${period}/CSV/pr/"
	mkdir "${period}/CSV/srad/"
	mkdir "${period}/CSV/tas/"
	mkdir "${period}/CSV/tasmax/"
	mkdir "${period}/CSV/tasmin/"
	mkdir "${period}/CSV/vapr/"
	mkdir "${period}/CSV/wind/"

	###
	# Create data directories.
	###
	mkdir "${period}/data/"
	mkdir "${period}/data/bio/"
	mkdir "${period}/data/pr/"
	mkdir "${period}/data/srad/"
	mkdir "${period}/data/tas/"
	mkdir "${period}/data/tasmax/"
	mkdir "${period}/data/tasmin/"
	mkdir "${period}/data/vapr/"
	mkdir "${period}/data/wind/"
	mkdir "${period}/data/properties/"

	###
	# Create clipped directories.
	###
	mkdir "${period}/ForgeniusClipped/"
	mkdir "${period}/ForgeniusClipped/bio/"
	mkdir "${period}/ForgeniusClipped/pr/"
	mkdir "${period}/ForgeniusClipped/srad/"
	mkdir "${period}/ForgeniusClipped/tas/"
	mkdir "${period}/ForgeniusClipped/tasmax/"
	mkdir "${period}/ForgeniusClipped/tasmin/"
	mkdir "${period}/ForgeniusClipped/vapr/"
	mkdir "${period}/ForgeniusClipped/wind/"

	###
	# Create clipped directories.
	###
	mkdir "${period}/Full/"
	mkdir "${period}/Full/bio/"
	mkdir "${period}/Full/pr/"
	mkdir "${period}/Full/srad/"
	mkdir "${period}/Full/tas/"
	mkdir "${period}/Full/tasmax/"
	mkdir "${period}/Full/tasmin/"
	mkdir "${period}/Full/vapr/"
	mkdir "${period}/Full/wind/"
	
done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
