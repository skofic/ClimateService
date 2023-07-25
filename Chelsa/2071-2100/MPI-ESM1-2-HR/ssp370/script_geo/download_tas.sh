#!/bin/sh

###
# Download average temperature files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
cat="tas"
epoc="$path/Chelsa/2071-2100/MPI-ESM1-2-HR/ssp370"
dest="${epoc}/Full/$cat"

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
	wget --continue --output-document="$dest/$name" "$url"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
    
done < "${path}/Chelsa/config/path_2071_2100_${cat}.txt"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
