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
fol="ano"
ini=1980
end=2022
epoc="${path}/DroughtObservatory/HCWI/${fol}"

echo "--------------------------------------------------"
echo "- DOWNLOAD HCWI ${fol} FILES"
echo "--------------------------------------------------"

###
# Iterate years.
###
for year in $(seq ${ini} 1 ${end})
do

	###
	# Set parameters.
	###
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_Daily_Maximum_Temperature_Anomaly/ver1-0-0/tpman_m_euu_${year}0101_${year}1231_d.zip"
	command="wget --continue $url --output-document=\"${epoc}/download/${year}.zip\""
	echo "$command"

done
