#!/bin/sh

###
# FORGENIUS_WP1_ENV_YEARLY.
###

###
# Load default parameters.
###
source "${HOME}/.ClimateService"

###
# Globals.
###
uuid="8194f5d7-b446-4dbc-b218-98fd2cb61095"
code="FORGENIUS_WP1_ENV_YEARLY"
plog="${path}/Characterisation/log"
list="${path}/Characterisation/config/${code}.txt"

###
# Parameters.
###
query_load="dump_gcu_date.aql"
query_group="group_gcu_date.aql"

###
# Scripts.
###
cmd_load="${path}/Characterisation/script/load_descriptors.sh"
cmd_group="${path}/Characterisation/script/group_descriptors.jsonl.sh"

###
# Load individual descriptor data files.
###
echo ""
echo "==> Loading descriptor data"
$cmd_load "$uuid" "$list" "${query_load}" | tee "${plog}/${acronym}.load.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi

###
# Load individual descriptor data files.
###
echo ""
echo "==> Grouping descriptor data"
$cmd_group "$code" "$list" "${query_group}" | tee "${plog}/${acronym}.group.log"
if [ $? -ne 0 ]
then
	echo "*************"
	echo "*** ERROR ***"
	echo "*************"
	exit 1
fi
