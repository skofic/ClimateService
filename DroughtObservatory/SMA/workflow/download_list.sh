#!/bin/sh

###
# Print list of files to download.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
fol="SMA"
ini=1995
end=2022
epoc="${path}/DroughtObservatory/${fol}"

echo "--------------------------------------------------"
echo "- DOWNLOAD ${fol} FILES"
echo "--------------------------------------------------"

###
# Iterate years.
###
for year in $(seq ${ini} 1 ${end})
do

	###
	# Set parameters.
	###
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_Soil_Moisture_Anomaly/ver2-1-0/smian_m_euu_${year}0101_${year}1221_t.zip"
	command="wget --continue $url --output-document=\"${epoc}/download/${year}.zip\""
	echo "$command"

done
