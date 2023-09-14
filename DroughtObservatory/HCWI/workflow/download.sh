#!/bin/sh

###
# Download files in download folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "--------------------------------------------------"
echo "- DOWNLOAD HCWI FILES"
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
	start_year=1980
	end_year=2022
	epoc="${path}/DroughtObservatory/FAPAR"

	echo "--------------------------------------------------"
	echo "- DOWNLOAD HCWI ${sub} FILES"
	echo "--------------------------------------------------"
	start=$(date +%s)

	###
	# Iterate years.
	###
	for year in $(seq ${start_year} 1 ${end_year})
	do

		###
		# Set URL.
		###
		url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_Daily_Maximum_Temperature_Anomaly/ver1-0-0/tpman_m_euu_${year}0101_${year}1231_d.zip"
	
		echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
		echo "< DOWNLOAD HCWI ${sub} YEAR ${year}"
		echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

		###
		# Download file.
		###
		wget --continue "$url" --output-document="${epoc}/download/${year}.zip"
# 		if [ $? -ne 0 ]
# 		then
# 			echo "*************"
# 			echo "*** ERROR ***"
# 			echo "*************"
# 			exit 1
# 		fi

	done

done

end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "- EXPAND HCWI FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
