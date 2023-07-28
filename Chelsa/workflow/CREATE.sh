#!/bin/sh

###
# Create Chelsa database.
#
# This script will create everything, it is supposed to be run
# just after cloning the git repository.
#
# Be aware that this involves downloading more than 200GB. of data
# and processing over 8 billion records: this means that the whole
# process will probably take more than a week, or even much more,
# depending on the computer that runs it.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Create top level log folder,
# and empty it if it exists.
###
mkdir "${path}/Chelsa/log/"
rm -fv "${path}/Chelsa/log/*.log"

###
# Globals.
###
period_1="${path}/Chelsa/1981-2010"
period_2="${path}/Chelsa/2011-2040/MPI-ESM1-2-HR/ssp370"
period_3="${path}/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370"
period_4="${path}/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"

echo "**************************************************"
echo "**************************************************"
echo "*** CREATE.sh"
echo "**************************************************"
echo "**************************************************"
CREATE_START=$(date +%s)

###
# Create period directories.
###
for period in period_1 period_2 period_3 period_4
do

	echo ""
	echo "**************************************************"
	echo "*** $period"
	echo "**************************************************"

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

	###
	# Create other directories.
	###
	mkdir "${period}/log/"
	
	###
	# Remove log files.
	###
	rm -fv "${period}/log/*.log"
	
	###
	# Prepare data.
	###
	cmd="${period}/workflow/1_PREPARE.sh"
	$cmd
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Process data.
	###
	cmd="${period}/workflow/2_PROCESS.sh"
	$cmd
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Combine bioclimatic data.
	###
	cmd="${period}/workflow/3_COMBINE_ANNUAL.sh"
	$cmd
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Combine monthly data.
	###
	cmd="${period}/workflow/4_COMBINE_MONTHLY.sh"
	$cmd
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Merge data.
	###
	cmd="${period}/workflow/5_MERGE.sh"
	$cmd
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
done

CREATE_END=$(date +%s)
elapsed=$((CREATE_END-CREATE_START))
echo ""
echo "**************************************************"
echo "**************************************************"
echo "*** CREATE.sh - TOTAL TIME: $elapsed seconds"
echo "**************************************************"
echo "**************************************************"
echo ""
