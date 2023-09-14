#!/bin/sh

###
# Expand ZIP files and place them in download folder.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "--------------------------------------------------"
echo "- EXPAND HCWI FILES"
echo "--------------------------------------------------"
start=$(date +%s)

###
# Iterate sub-directories.
###
for sub in "ano" "max" "min"
do

	###
	# Parameters.
	###
	epoc="${path}/DroughtObservatory/HCWI/${sub}"
	
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

done

end=$(date +%s)
elapsed=$((end-start))
echo "--------------------------------------------------"
echo "- EXPAND HCWI FILES: $elapsed seconds"
echo "--------------------------------------------------"
echo ""
