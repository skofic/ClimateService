#!/bin/sh

###
# Unzip all files into their respective directories.
#
# The script will unzip all files in the CSV/download directory
# ignoring the zip folder structure and overwriting existing files.
#
# Once extracted, the script will move all files into their
# directories creating the later in the process.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= extract_zip_files.sh"
echo "=================================================="
echo $$
echo "=================================================="
echo ""
start_extract_zip_files=$(date +%s)

###
# Set path parameters.
###
epoc="${path}/RemoteSensing/CSV"

###
# Unzip all files ignoring directory and overwriting.
###
echo "--------------------------------------------------"
echo "- Extracting zip files to: ${epoc}/download/"
echo "--------------------------------------------------"
start=$(date +%s)
# I am using a loop, because unzip doesn't accept wildcards
# in the ArangoDB docker installation.
for name in "${path}/RemoteSensing/download/"*.zip
do
	unzip -jo "$name" -d "${path}/RemoteSensing/download/"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "= Extracting zip files: $elapsed seconds"
echo "--------------------------------------------------"
echo ""

###
# GZip all .csv files.
###
echo "--------------------------------------------------"
echo "- GZipping CSV files"
echo "--------------------------------------------------"
start=$(date +%s)
gzip "${path}/RemoteSensing/download/"*.csv
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "= GZipping CSV files: $elapsed seconds"
echo "--------------------------------------------------"
echo ""

echo "--------------------------------------------------"
echo "- Move files"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Topographic files.
###
dir="topography"
mkdir -p "${epoc}/${dir}"
for name in "aspect" "elevation" "slope"
do
	mv -f "${path}/RemoteSensing/download/${name}.csv.gz" "${epoc}/${dir}/${name}.csv.gz"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

###
# Yearly files.
###
dir="std_date_span_year"
mkdir -p "${epoc}/${dir}"
for name in "biomass_2010" "canopy_height_2019" "dominant_forest_type"
do
	mv -f "${path}/RemoteSensing/download/${name}.csv.gz" "${epoc}/${dir}/${name}.csv.gz"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

###
# Monthly files.
###
dir="std_date_span_month"
mkdir -p "${epoc}/${dir}"
for name in "Lai_500m" "LST_Day_1km" "ndvi" "NDWI"
do
	mv -f "${path}/RemoteSensing/download/${name}.csv.gz" "${epoc}/${dir}/${name}.csv.gz"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

###
# Daily files.
###
dir="${epoc}/std_date_span_day"

###
# Single descriptors.
###
for name in "incoming_solar_radiation" "latent_heat_flux" "relative_humidity" "temperature_2m" "total_precipitation" "wind_speed"
do
	mkdir -p "${dir}/${name}"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	mv -f "${path}/RemoteSensing/download/${name}"* "${dir}/${name}/"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
done

###
# Descriptor families.
###
for name in "soil_temperature" "soil_water"
do
	mkdir -p "${dir}/${name}"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	for kind in "7cm" "28cm" "100cm" "289cm"
	do
		mkdir -p "${dir}/${name}/${name}_${kind}"
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	
		mv -f "${path}/RemoteSensing/download/${name}_${kind}"* "${dir}/${name}/${name}_${kind}/"
		if [ $? -ne 0 ]
		then
			echo "*************"
			echo "*** ERROR ***"
			echo "*************"
			exit 1
		fi
	
	done
	
done

end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "= Move files: $elapsed seconds"
echo "--------------------------------------------------"
echo ""

###
# Delete all zip files.
###
echo "--------------------------------------------------"
echo "- Removing zip files"
echo "--------------------------------------------------"
start=$(date +%s)
rm -f "${path}/RemoteSensing/download/"*.zip
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "= Removing zip files: $elapsed seconds"
echo "--------------------------------------------------"
echo ""

end_extract_zip_files=$(date +%s)
elapsed=$((end_extract_zip_files-start_extract_zip_files))
echo "=================================================="
echo "= extract_zip_files.sh: $elapsed seconds"
echo "=================================================="
echo ""
