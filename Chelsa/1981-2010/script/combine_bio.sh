#!/bin/sh

###
# Combine all 1981-2010 monthly processed files into collection temp_pong.
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

###
# Globals.
###
epoc="$path/Chelsa/1981-2010"
host="http+tcp://localhost:8529"
base="Climate"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

###
# Iterate processed files.
###

echo "====================================================================="
echo "= Stack files into temp_pong"
echo "====================================================================="
first=1
for name in "ai", "bio1", "bio2", "bio3", "bio4", "bio5", "bio6", "bio7", "bio8", "bio9", "bio10", "bio11", "bio12", "bio13", "bio14", "bio15", "bio16", "bio17", "bio18", "bio19", "cmi_max", "cmi_mean", "cmi_min", "cmi_range", "fcf", "fgd", "gdd0", "gdd5", "gdd10", "gddlgd0", "gddlgd5", "gddlgd10", "gdgfgd0", "gdgfgd5", "gdgfgd10", "gsl", "gsp", "gst", "hurs_max", "hurs_mean", "hurs_min", "hurs_range", "kg0", "kg1", "kg2", "kg3", "kg4", "kg5", "lgd", "ngd0", "ngd5", "ngd10", "npp", "pet_penman_max", "pet_penman_mean", "pet_penman_min", "pet_penman_range", "rsds_max", "rsds_mean", "rsds_min", "rsds_range", "scd", "sfcWind_max", "sfcWind_mean", "sfcWind_min", "sfcWind_range", "swe", "vpd_max", "vpd_mean", "vpd_min", "vpd_range"
do

	echo "==> $name"
	start=$(date +%s)
	
	###
	# Import file into database.
	###
	if [ $first -eq 1 ]
	then
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$epoc/data/bio/${name}.csv.gz" \
			--type "csv" \
			--collection "temp_pong" \
			--ignore-missing \
			--overwrite
	else
		arangoimport \
			--server.endpoint "$host" \
			--server.database "$base" \
			--server.username "$1" \
			--server.username "$2" \
			--file "$epoc/data/bio/${name}.csv.gz" \
			--type "csv" \
			--collection "temp_pong" \
			--ignore-missing
	fi
	first=0
	
	end=$(date +%s)
	elapsed=$((end-start))
	echo "Elapsed time: $elapsed seconds"

done
