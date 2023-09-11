#!/bin/sh

###
# Convert TIF files and place them in CSV folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
prefix="fapan_m_euu_"
epoc="${path}/GlobalDroughtObservatory/FAPAN"

echo "--------------------------------------------------"
echo "- CONVERT FILES"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate TIF files.
###
for file in "${epoc}/download/"*.tif
do
	
	###
	# Get date from filename.
	###
	len=${#prefix}
	name=$(basename -- "$file")
	date=${name:${len}:8}
	
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> CONVERT WGS84 FROM FAPAN/download/${name} TO FAPAN/converted/${date}.tif"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	
	###
	# Convert to WGS84 and geographic units.
	###
	gdalwarp -overwrite -t_srs EPSG:4326 -dstnodata -999999999.0 -r near -of GTiff -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "$file" "${epoc}/converted/${date}.tif"	
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> CONVERT CSV FROM FAPAN/converted/${date}.tif TO FAPAN/CSV/${date}.csv"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	
	###
	# Convert to CSV.
	###
	gdal2xyz.py -skipnodata -csv "${epoc}/converted/${date}.tif" "${epoc}/CSV/${date}.csv"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	echo ""

done

echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"
echo "␡ DELETE downloaded files"
echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"

###
# Iterate TIF files.
###
for file in "${epoc}/download/"*.tif
do
	
	###
	# Delete file.
	###
	rm -f "$file"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi

done

echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"
echo "␡ DELETE converted files"
echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"

###
# Iterate TIF files.
###
for file in "${epoc}/converted/"*.tif
do
	
	###
	# Delete file.
	###
	rm -f "$file"
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
echo "- CONVERT FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
