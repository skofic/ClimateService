#!/bin/sh

###
# Create remote sensing data repository.
#
# The script will process and place the downloaded zip files,
# it will process the data and harmonise it to data standards
# and it will merge the data into the ShapeData collection.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Yearly data dictionary.
###

echo "=================================================="
echo "= CREATE.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
CREATE_start=$(date +%s)

# ###
# # Unzip all files and place them in respective directories.
# ###
# cmd="${path}/RemoteSensing/scripts/extract_zip_files.sh"
# $cmd | tee "${path}/RemoteSensing/log/1_extract_zip_files.log"
# if [ $? -ne 0 ]
# then
# 	echo "*************"
# 	echo "*** ERROR ***"
# 	echo "*************"
# 	exit 1
# fi

###
# Process and stack all yearly data.
###
cmd="${path}/RemoteSensing/scripts/process_yearly_data.sh"
$cmd "temp_ping" "temp_annual" "${path}/RemoteSensing/config/yearly_dict.txt" | tee "${path}/RemoteSensing/log/2_process_yearly_data.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

CREATE_end=$(date +%s)
elapsed=$((CREATE_end-CREATE_start))
echo ""
echo "=================================================="
echo "= CREATE.sh: $elapsed seconds"
echo "=================================================="
echo ""
