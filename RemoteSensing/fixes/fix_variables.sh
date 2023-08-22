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
fix_variables=$(date +%s)

###
# Create directories.
##
echo ""
echo "<<< CREATE CACHE DIRECTORY >>>"
echo ""
mkdir -p "$expo"
mkdir -p "${epoc}/data"

###
# Fix Shapes collection.
###
echo ""
echo "<<< FIX SHAPES >>>"
echo ""
cmd="${epoc}/script_data/update_shapes.sh"
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
cmd="${epoc}/script_data/update_unit_shapes.sh"
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
cmd="${epoc}/script_data/update_shape_data.sh"
$cmd "ShapeData"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

fix_variables_END=$(date +%s)
elapsed=$((fix_variables_END-fix_variables_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> fix_variables.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
