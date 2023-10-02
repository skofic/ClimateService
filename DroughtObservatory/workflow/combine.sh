#!/bin/sh

###
# Combine data into area dumps.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
epoc="${path}/DroughtObservatory"

echo "=================================================="
echo "= COMBINE FILES"
echo "=================================================="
start=$(date +%s)

###
# Launch jobs sequentially.
###
for area in "1km" "5km" "25km"
do
	
	###
	# Stack dumps.
	###
	cmd="${epoc}/workflow/stack_${area}.sh"
	$cmd | tee "${epoc}/log/3_STACK_${area}.log"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Combine map dumps.
	###
	cmd="${epoc}/workflow/map_${area}.sh"
	$cmd | tee "${epoc}/log/4_MAP_${area}.log"
	if [ $? -ne 0 ]
	then
		echo "*************"
		echo "*** ERROR ***"
		echo "*************"
		exit 1
	fi
	
	###
	# Combine data dumps.
	###
	cmd="${epoc}/workflow/combine_${area}.sh"
	$cmd | tee "${epoc}/log/5_COMBINE_${area}.log"
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
echo "= COMBINE FILES: $elapsed seconds"
echo "=================================================="
echo ""
