#!/bin/sh

###
# Print list of files to download.
###

###
# Globals.
###
ini=2012
end=2022
epoc="${path}/DroughtObservatory/FAPAR"

echo "--------------------------------------------------"
echo "- DOWNLOAD CDI FILES"
echo "--------------------------------------------------"

###
# Iterate years.
###
for year in $(seq ${ini} 1 ${end})
do

	###
	# Set parameters.
	###
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_Combined_Drought_Indicator/ver3-0-1/cdinx_m_euu_${year}0101_${year}1221_t.zip"
	command="wget --continue $url --output-document=\"${epoc}/download/${year}.zip\""
	echo "$command"

done
