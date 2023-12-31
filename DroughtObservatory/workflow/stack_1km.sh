#!/bin/sh

###
# Stack files.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
collection="temp_pang"
epoc="${path}/DroughtObservatory"

echo "=================================================="
echo "= STACK 1km FILES"
echo "=================================================="
start=$(date +%s)

###
# Iterate folders.
###
first=1
for folder in "FAPAN" "FAPAR"
do
	
	###
	# Iterate files.
	###
	for file in "${epoc}/${folder}/data"/*.jsonl.gz
	do
		
		echo "==> ${file}"
		echo "==> ${first}"
	
		###
		# Stack data dumps.
		###
		if [ $first -eq 1 ]
		then
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$user" \
				--server.password "$pass" \
				--file "$file" \
				--type "jsonl" \
				--collection "$collection" \
				--auto-rate-limit true \
				--overwrite
			if [ $? -ne 0 ]
			then
				echo "*************"
				echo "*** ERROR ***"
				echo "*************"
				exit 1
			fi
		else
			arangoimport \
				--server.endpoint "$host" \
				--server.database "$base" \
				--server.username "$user" \
				--server.password "$pass" \
				--file "$file" \
				--type "jsonl" \
				--collection "$collection" \
				--auto-rate-limit true
			if [ $? -ne 0 ]
			then
				echo "*************"
				echo "*** ERROR ***"
				echo "*************"
				exit 1
			fi
		fi
		
		first=0
		
	done
	
done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= STACK 1km FILES: $elapsed seconds"
echo "=================================================="
echo ""
