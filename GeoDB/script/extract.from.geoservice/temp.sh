#!/bin/sh

###
# Import data.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> 4.import.data.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
START=$(date +%s)

###
# Import WorldClim.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/import.data.worldclim.sh"
sh $cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Import ShapeData.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/import.data.rs.sh"
sh $cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Import DroughtObservatory.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/import.data.edo.sh"
sh $cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

END=$(date +%s)
elapsed=$((END-START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> 4.import.data.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
