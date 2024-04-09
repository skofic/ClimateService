#!/bin/sh

###
# Export geometries.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
file="${path}/GeoDB/data/1.geometries.chelsa.jsonl.gz"
query="${path}/GeoDB/script/extract.from.geoservice/aql/Chelsa.aql"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export..sh"
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

END=$(date +%s)
elapsed=$((END-START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> export..sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
