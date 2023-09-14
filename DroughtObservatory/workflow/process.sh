#!/bin/sh

###
# Process CSV files and dump to JSONL.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

echo "=================================================="
echo "= PROCESS FILES"
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
	# Launch script in batch.
	###
	cmd="${epoc}/workflow/2_process.sh"
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
echo "= PROCESS FILES: $elapsed seconds"
echo "=================================================="
echo ""
