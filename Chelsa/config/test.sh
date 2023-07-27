#!/bin/sh

###
# Convert precipitation maps to CSV.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
name="pr"

###
# Parameters.
###
epoc="${path}/Chelsa/1981-2010"
from="${epoc}/ForgeniusClipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped precipitation variables to CSV format.
###
cmd="${path}/Chelsa/script_geo/convert.sh"
for month in "01" "02" 
do

	###
	# Convert to CSV and gzip.
	###
	$cmd "${from}/${name}_${month}.tif" "${dest}/${name}_${month}.csv"
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
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
