#!/bin/sh

###
# Download, clip and convert bioclimatic files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
dest="${path}/WorldClim/1970-2000/Full"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Download zip file.
###
wget --continue "https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_bio.zip" --output-document="${dest}/bio.zip"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Unzip file.
###
unzip "${dest}/bio.zip" -d "$dest"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Place files.
###
while read -r line
do

	###
	# Get source URL and destination file path.
	###
    old=$(echo $line | cut -d ' ' -f 1)
    new=$(echo $line | cut -d ' ' -f 2)
    
	###
	# Move file.
	###
	mv --force "${dest}/${old}" "${dest}/bio/${new}"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
    
done < "${path}/WorldClim/config/path_1970_2000_bio.txt"

###
# Remove zip file.
###
rm -f "${dest}/bio.zip"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
