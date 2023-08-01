#!/bin/sh

###
# Convert bioclimatic maps to CSV.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "====================================================================="
echo "= Convert bioclimatic variables to CSV."
echo "====================================================================="

###
# Globals.
###
name="bio"
epoc="${path}/WorldClim/1970-2000"

###
# Parameters.
###
from="${epoc}/ForgeniusClipped/${name}"
dest="${epoc}/CSV/${name}"

echo "--------------------------------------------------"
echo "==> ${name}"
start=$(date +%s)

###
# Convert clipped bioclimatic variables to CSV format.
###
cmd="${path}/WorldClim/script_geo/convert.sh"
for var in "bio01" "bio02" "bio03" "bio04" "bio05" "bio06" "bio07" "bio08" "bio09" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19"
do

	###
	# Convert to CSV and gzip.
	###
	$cmd "${from}/${var}.tif" "${dest}/${var}.csv"
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
