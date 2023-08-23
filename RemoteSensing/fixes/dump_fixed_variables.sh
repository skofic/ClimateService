#!/bin/sh

###
# Dump Shapes, UnitShapes and ShapeData with fixed variables.
#
# Before loading the data again into the collections you should
# delete and re-create all indexes referencing obsolete variables.
###

###
# Load default parameters.
###
source "${HOME}/.GeoService"
epoc="$path/RemoteSensing/fixes"

###
# Parameters.
###
cmd="${epoc}/script_data/dump_data.sh"

echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> dump_fixed_variables.sh"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
dump_fixed_variables_START=$(date +%s)

###
# Create directories.
##
echo ""
echo "<<< CREATE CACHE AND DATA DIRECTORIES >>>"
echo ""
mkdir -p "$expo"
mkdir -p "${epoc}/data"

###
# Fix Shapes collection.
###
echo ""
echo "<<< DUMP FIXED SHAPES >>>"
echo ""
$cmd "Shapes" "${epoc}/script_query/update_shapes.aql"
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
$cmd "UnitShapes" "${epoc}/script_query/update_unit_shapes.aql"
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
$cmd "ShapeData" "${epoc}/script_query/update_shape_data.aql"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

dump_fixed_variables_END=$(date +%s)
elapsed=$((dump_fixed_variables_END-dump_fixed_variables_START))
echo ""
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo "==> dump_fixed_variables.sh - TOTAL TIME: $elapsed seconds"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
echo ""
