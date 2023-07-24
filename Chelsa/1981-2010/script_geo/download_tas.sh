#!/bin/sh

###
# Download bioclimatic files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
dest="${path}/Chelsa/1981-2010/Full/bio"

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
    
done < "${path}/Chelsa/config/path_1981_2010_tas.txt"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
