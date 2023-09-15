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
fol="FAPAN"
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
	url="https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/DROUGHTOBS/Drought_Observatories_datasets/EDO_Fraction_of_Absorbed_Photosynthetically_Active_Radiation_Anomalies_fAPAR/ver1-3-2/fapan_m_euu_${year}0101_${year}1221_t.zip"
	command="wget --continue $url --output-document=\"${epoc}/download/${year}.zip\""
	echo "$command"

done
