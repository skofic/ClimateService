#!/bin/sh

###
# Combine all 2041-2070 monthly processed files into collection temp_pong.
###

###
# Globals.
###
path="/usr/local/Chelsa/2041-2070/MPI-ESM1-2/ssp370"
host="http+tcp://localhost:8529"
base="Climate"
pass="CAULDRON sycamore pioneer quite"
head="/usr/local/Chelsa/config/header.csv"
expo="/usr/local/ArangoDB/exports/"

###
# Iterate processed files.
###

echo "====================================================================="
echo "= Stack files into temp_pong"
echo "====================================================================="
first=1
for name in "bio1" "bio2" "bio3" "bio4" "bio5" "bio6" "bio7" "bio8" "bio9" "bio10" "bio11" "bio12" "bio13" "bio14" "bio15" "bio16" "bio17" "bio18" "bio19" "fcf" "fgd" "gdd0" "gdd5" "gdd10" "gddlgd0" "gddlgd5" "gddlgd10" "gdgfgd0" "gdgfgd5" "gdgfgd10" "gsl" "gsp" "gst" "kg0" "kg1" "kg2" "kg3" "kg4" "kg5" "lgd" "ngd0" "ngd5" "ngd10" "npp" "scd" "swe"
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
			--file "$path/data/bio/${name}.csv.gz" \
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
			--file "$path/data/bio/${name}.csv.gz" \
			--type "csv" \
			--collection "temp_pong" \
			--ignore-missing
	fi
	first=0
	
	end=$(date +%s)
	elapsed=$((end-start))
	echo "Elapsed time: $elapsed seconds"

done
