#!/bin/sh

###
# Fix variables.
#
# Note that you should remove all indexes before running this script,
# and after having run it add the indexes again with the correct property names.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
epoc="$path/RemoteSensing/fixes"

###
# Parameters.
###
cmd="${epoc}/script_data/load_data.sh"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> load_fixed_variables.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
load_fixed_variables_START=$(date +%s)

###
# Fix Shapes collection.
###
echo ""
echo "<<< LOAD SHAPES >>>"
echo ""
$cmd "Shapes"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Fix UnitShapes collection.
###
echo ""
echo "<<< FIX UNIT-SHAPES >>>"
echo ""
$cmd "UnitShapes"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Fix UnitShapes collection.
###
echo ""
echo "<<< FIX SHAPE-DATA >>>"
echo ""
$cmd "ShapeData"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

load_fixed_variables_END=$(date +%s)
elapsed=$((load_fixed_variables_END-load_fixed_variables_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> load_fixed_variables.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
