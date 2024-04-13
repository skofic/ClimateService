#!/bin/sh

###
# Export geometries.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> 1.export.geometry.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
START=$(date +%s)

###
# Export Chelsa.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/export.geometries.chelsa.sh"
sh $cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Export WorldClim.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/export.geometries.worldclim.sh"
sh $cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Export ShapeData.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/export.geometries.rs.sh"
sh $cmd
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Export DroughtObservatory.
###
cmd="${path}/GeoDB/script/extract.from.geoservice/export.geometries.edo.sh"
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
echo "==> 1.export.geometry.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
