#!/bin/sh

###
# Download and clip maps.
###

###
# Parameters.
###
read arg
user="$arg"
read arg
pass="$arg"
read arg
path="$arg"

echo "**************************************************"
echo "DOWNLOAD FILES"
echo "**************************************************"
start=$(date +%s)
for code in "bio" "pr" "tas" "tasmax" "tasmin"
do
	echo "===> $code"
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
		wget --continue --output-document="${path}/Chelsa/1981-2010/Full/$code/$name" "$url"
	
	done < "${path}/Chelsa/config/path_1981_2010_$code.txt"
done

end=$(date +%s)
elapsed=$((end-start))
echo "=================================================="
echo "DOWNLOAD FILES: $elapsed seconds"
echo "=================================================="
echo ""
