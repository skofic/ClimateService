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

###
# Create log directory.
###
mkdir -p "${path}/RemoteSensing/log"

###
# Unzip all files and place them in respective directories.
###
cmd="${path}/RemoteSensing/scripts/extract_zip_files.sh"
$cmd | tee "${path}/RemoteSensing/log/1_extract_zip_files.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Create other directories.
###
mkdir -p "${path}/RemoteSensing/data"
mkdir -p "${path}/RemoteSensing/JSONL"

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

###
# Process and stack all monthly data.
###
cmd="${path}/RemoteSensing/scripts/process_monthly_data.sh"
$cmd "temp_ping" "temp_monthly" "${path}/RemoteSensing/config/monthly_dict.txt" | tee "${path}/RemoteSensing/log/3_process_monthly_data.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Process and stack all daily data.
###
cmd="${path}/RemoteSensing/scripts/process_daily_data.sh"
$cmd "temp_ping" "temp_pong" "temp_daily" "${path}/RemoteSensing/config/daily_dict.txt" | tee "${path}/RemoteSensing/log/4_process_daily_data.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Process and stack all daily soil temperature.
###
cmd="${path}/RemoteSensing/scripts/process_daily_soil_temp_data.sh"
$cmd "temp_ping" "temp_pong" "temp_daily" "${path}/RemoteSensing/config/daily_soil_temp_dict.txt" | tee "${path}/RemoteSensing/log/5_process_daily_soil_temp_data.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Process and stack all daily soil water.
###
cmd="${path}/RemoteSensing/scripts/process_daily_soil_water_data.sh"
$cmd "temp_ping" "temp_pong" "temp_daily" "${path}/RemoteSensing/config/daily_soil_water_dict.txt" | tee "${path}/RemoteSensing/log/6_process_daily_soil_water_data.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Merge daily data.
###
cmd="${path}/RemoteSensing/scripts/merge_daily_data.sh"
$cmd "temp_daily" | tee "${path}/RemoteSensing/log/7_merge_daily_data.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Load remote sensing data.
###
cmd="${path}/RemoteSensing/scripts/load_data.sh"
$cmd "GeoService" "ShapeData" | tee "${path}/RemoteSensing/log/8_load_data.log"
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
