#!/bin/sh

###
# Convert TIF maps to CSV format.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= PREPARE FILES"
echo "=================================================="
start=$(date +%s)

###
# Launch jobs sequentially.
###
for folder in "FAPAN" "FAPAR" "HCWI" "CDI" "SMA" "SMI" "TWS"
do
	
	###
	# Parameters.
	###
	epoc="${path}/DroughtObservatory/${folder}"

	###
	# Launch script sequentially.
	###
	cmd="${epoc}/workflow/1_prepare.sh"
	$cmd
	
	###
	# Handle error.
	###
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
echo "=================================================="
echo "= PREPARE FILES: $elapsed seconds"
echo "=================================================="
echo ""
