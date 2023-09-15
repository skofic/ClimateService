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
fol="TWS"
ini=2002
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
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_GRACE_Total_Water_Storage_Anomaly/ver1-1-0/twsan_m_euu_${year}0101_${year}1201_m.zip"
	command="wget --continue $url --output-document=\"${epoc}/download/${year}.zip\""
	echo "$command"

done
