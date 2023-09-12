#!/bin/sh

###
# Expand ZIP files and place them in download folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/GlobalDroughtObservatory/SMA"

echo "--------------------------------------------------"
echo "- EXPAND FILES"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate zip files.
###
for file in "${epoc}/download/"*.zip
do
	
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo "> EXPAND ${file}"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

	###
	# Unzip file.
	###
	unzip -o "$file" -d "${epoc}/download/"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi

done

###
# Delete ZIP files.
###
for file in "${epoc}/download/"*.zip
do
	
	echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"
	echo "␡ DELETE ${file}"
	echo "␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡␡"

	###
	# Delete file.
	###
	rm -f "$file"
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
echo "--------------------------------------------------"
echo "- EXPAND FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
