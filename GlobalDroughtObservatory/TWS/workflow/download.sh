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
start_year=2002
end_year=2022
epoc="${path}/GlobalDroughtObservatory/FAPAR"

echo "--------------------------------------------------"
echo "- DOWNLOAD TWS FILES"
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
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_GRACE_Total_Water_Storage_Anomaly/ver1-1-0/twsan_m_euu_${year}0101_${year}1201_m.zip"
	
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	echo "< DOWNLOAD TWS YEAR ${year}"
	echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

	###
	# Download file.
	###
	wget --continue "$url" --output-document="${epoc}/download/${year}.zip"
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
echo "- DOWNLOAD TWS FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
