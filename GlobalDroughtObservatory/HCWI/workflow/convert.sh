#!/bin/sh

###
# Convert TIF files and place them in CSV folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "--------------------------------------------------"
echo "- CONVERT HCWI FILES"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate sub-directories.
###
for sub in "ano" "max" "min"
do

	###
	# Parameters.
	###
	epoc="${path}/GlobalDroughtObservatory/HCWI/${sub}"
	prefix="tpman_m_euu_"
	case "$sub" in
		"ano")
		prefix="tpman_m_euu_"
		;;
		"max")
		prefix="tpmax_m_euu_"
		;;
		"min")
		prefix="tpmin_m_euu_"
		;;
	esac
	
	echo ""
	echo "--------------------------------------------------"
	echo "- ${sub}"
	echo "--------------------------------------------------"

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
		echo ">>> CONVERT WGS84 FROM HCWI/${sub}/download/${name} TO HCWI/${sub}/converted/${date}.tif"
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
		echo ">>> CONVERT CSV FROM HCWI/${sub}/converted/${date}.tif TO HCWI/${sub}/CSV/${date}.csv"
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

done

end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "- CONVERT HCWI FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
