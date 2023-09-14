#!/bin/sh

###
# Download files in download folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
start_year=1995
end_year=2022
epoc="${path}/DroughtObservatory/FAPAR"

echo "--------------------------------------------------"
echo "- DOWNLOAD SMA FILES"
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
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_Soil_Moisture_Anomaly/ver2-1-0/smian_m_euu_${year}0101_${year}1221_t.zip"
	
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	echo "< DOWNLOAD SMA YEAR ${year}"
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

	###
	# Download file.
	###
	wget --continue "$url" --output-document="${epoc}/download/${year}.zip"
# 	if [ $? -ne 0 ]
# 	then
# 		echo "*************"
# 		echo "*** ERROR ***"
# 		echo "*************"
# 		exit 1
# 	fi

done

end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "- DOWNLOAD SMA FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
