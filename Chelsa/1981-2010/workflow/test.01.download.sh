#!/bin/sh

###
# Download and clip maps.
###

###
# Find default parameters.
###
conf=$(dirname "$(realpath  "$BASH_SOURCE")")
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="$(dirname "$conf")"
conf="${conf}/config.txt"

###
# Load default parameters.
###
source "$conf"

echo "=================================================="
echo "= DOWNLOAD FILES"
echo "=================================================="
start=$(date +%s)

for code in "bio" "pr" "tas"
do

	echo "================"
	echo "===> $code"
	echo "================"

	###
	# Download files.
	###
	dest="${path}/Chelsa/1981-2010/Full/$code"
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
	
	done < "${path}/Chelsa/config/test_1981_2010_${code}.txt"

done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "= DOWNLOAD FILES: $elapsed seconds"
echo "=================================================="
echo ""
