#!/bin/sh

###
# Prepare data: download, clip to region and convert to GeoJSON.
###
start=$(date +%s)

./01.download.sh
./02.clip.sh
./03.convert.sh

end=$(date +%s)
elapsed=$((end-start))
echo "==>: $elapsed seconds"
echo ""
