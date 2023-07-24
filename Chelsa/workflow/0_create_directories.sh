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
period_1="${path}/Chelsa/1981-2010"
period_2="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
period_3="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
period_4="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Create period directories.
###
for period in period_1 period_2 period_3 period_4
do

	###
	# Create CSV directories.
	###
	mkdir "${period}/CSV/"
	mkdir "${period}/CSV/bio/"
	mkdir "${period}/CSV/pr/"
	mkdir "${period}/CSV/tas/"
	mkdir "${period}/CSV/tasmax/"
	mkdir "${period}/CSV/tasmin/"

	###
	# Create data directories.
	###
	mkdir "${period}/data/"
	mkdir "${period}/data/bio/"
	mkdir "${period}/data/pr/"
	mkdir "${period}/data/tas/"
	mkdir "${period}/data/tasmax/"
	mkdir "${period}/data/tasmin/"
	mkdir "${period}/data/properties/"

	###
	# Create clipped directories.
	###
	mkdir "${period}/ForgeniusClipped/"
	mkdir "${period}/ForgeniusClipped/bio/"
	mkdir "${period}/ForgeniusClipped/pr/"
	mkdir "${period}/ForgeniusClipped/tas/"
	mkdir "${period}/ForgeniusClipped/tasmax/"
	mkdir "${period}/ForgeniusClipped/tasmin/"

	###
	# Create clipped directories.
	###
	mkdir "${period}/Full/"
	mkdir "${period}/Full/bio/"
	mkdir "${period}/Full/pr/"
	mkdir "${period}/Full/tas/"
	mkdir "${period}/Full/tasmax/"
	mkdir "${period}/Full/tasmin/"
	
done

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
