#!/bin/sh

###
# Download period files.
# Download all files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
peri="2021_2040"
cmd="${path}/WorldClim/script_geo/download.sh"
epoc="${path}/WorldClim/2021-2040/MPI-ESM1-2-HR/ssp370"

###
# Parameters.
###
dest="${epoc}/Full"
dict="${path}/WorldClim/config/path_${peri}.txt"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate list of files.
###
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    url=$(echo $line | cut -d ' ' -f 1)
    name=$(echo $line | cut -d ' ' -f 2)
    
	###
	# Download file.
	###
	$cmd "${url}" "${dest}/${name}"
 	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
   
done < "$dict"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
