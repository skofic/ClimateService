#!/bin/sh

###
# Clip maps to useful region.
###

###
# Parameters.
###
read arg
user="$arg"
read arg
pass="$arg"
read arg
path="$arg"

###
# Globals.
###
name="bio"
from="${path}/Chelsa/1981-2010/ForgeniusClipped/${name}"
dest="${path}/Chelsa/1981-2010/CSV/$name"

echo "--------------------------------------------------"
start=$(date +%s)

###
# Convert clipped bioclimatic variables to CSV format.
###
gdal2xyz.py -skipnodata -csv "$from/ai.tif" "$dest/ai.csv"
gdal2xyz.py -skipnodata -csv "$from/bio01.tif" "$dest/bio01.csv"
gdal2xyz.py -skipnodata -csv "$from/bio02.tif" "$dest/bio02.csv"
gdal2xyz.py -skipnodata -csv "$from/bio03.tif" "$dest/bio03.csv"
gdal2xyz.py -skipnodata -csv "$from/bio04.tif" "$dest/bio04.csv"
gdal2xyz.py -skipnodata -csv "$from/bio05.tif" "$dest/bio05.csv"
gdal2xyz.py -skipnodata -csv "$from/bio06.tif" "$dest/bio06.csv"
gdal2xyz.py -skipnodata -csv "$from/bio07.tif" "$dest/bio07.csv"
gdal2xyz.py -skipnodata -csv "$from/bio08.tif" "$dest/bio08.csv"
gdal2xyz.py -skipnodata -csv "$from/bio09.tif" "$dest/bio09.csv"
gdal2xyz.py -skipnodata -csv "$from/bio10.tif" "$dest/bio10.csv"
gdal2xyz.py -skipnodata -csv "$from/bio11.tif" "$dest/bio11.csv"
gdal2xyz.py -skipnodata -csv "$from/bio12.tif" "$dest/bio12.csv"
gdal2xyz.py -skipnodata -csv "$from/bio13.tif" "$dest/bio13.csv"
gdal2xyz.py -skipnodata -csv "$from/bio14.tif" "$dest/bio14.csv"
gdal2xyz.py -skipnodata -csv "$from/bio15.tif" "$dest/bio15.csv"
gdal2xyz.py -skipnodata -csv "$from/bio16.tif" "$dest/bio16.csv"
gdal2xyz.py -skipnodata -csv "$from/bio17.tif" "$dest/bio17.csv"
gdal2xyz.py -skipnodata -csv "$from/bio18.tif" "$dest/bio18.csv"
gdal2xyz.py -skipnodata -csv "$from/bio19.tif" "$dest/bio19.csv"
gdal2xyz.py -skipnodata -csv "$from/clt_max.tif" "$dest/clt_max.csv"
gdal2xyz.py -skipnodata -csv "$from/clt_mean.tif" "$dest/clt_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/clt_min.tif" "$dest/clt_min.csv"
gdal2xyz.py -skipnodata -csv "$from/clt_range.tif" "$dest/clt_range.csv"
gdal2xyz.py -skipnodata -csv "$from/cmi_max.tif" "$dest/cmi_max.csv"
gdal2xyz.py -skipnodata -csv "$from/cmi_mean.tif" "$dest/cmi_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/cmi_min.tif" "$dest/cmi_min.csv"
gdal2xyz.py -skipnodata -csv "$from/cmi_range.tif" "$dest/cmi_range.csv"
gdal2xyz.py -skipnodata -csv "$from/fcf.tif" "$dest/fcf.csv"
gdal2xyz.py -skipnodata -csv "$from/fgd.tif" "$dest/fgd.csv"
gdal2xyz.py -skipnodata -csv "$from/gdd0.tif" "$dest/gdd0.csv"
gdal2xyz.py -skipnodata -csv "$from/gdd5.tif" "$dest/gdd5.csv"
gdal2xyz.py -skipnodata -csv "$from/gdd10.tif" "$dest/gdd10.csv"
gdal2xyz.py -skipnodata -csv "$from/gddlgd0.tif" "$dest/gddlgd0.csv"
gdal2xyz.py -skipnodata -csv "$from/gddlgd5.tif" "$dest/gddlgd5.csv"
gdal2xyz.py -skipnodata -csv "$from/gddlgd10.tif" "$dest/gddlgd10.csv"
gdal2xyz.py -skipnodata -csv "$from/gdgfgd0.tif" "$dest/gdgfgd0.csv"
gdal2xyz.py -skipnodata -csv "$from/gdgfgd5.tif" "$dest/gdgfgd5.csv"
gdal2xyz.py -skipnodata -csv "$from/gdgfgd10.tif" "$dest/gdgfgd10.csv"
gdal2xyz.py -skipnodata -csv "$from/gsl.tif" "$dest/gsl.csv"
gdal2xyz.py -skipnodata -csv "$from/gsp.tif" "$dest/gsp.csv"
gdal2xyz.py -skipnodata -csv "$from/gst.tif" "$dest/gst.csv"
gdal2xyz.py -skipnodata -csv "$from/hurs_max.tif" "$dest/hurs_max.csv"
gdal2xyz.py -skipnodata -csv "$from/hurs_mean.tif" "$dest/hurs_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/hurs_min.tif" "$dest/hurs_min.csv"
gdal2xyz.py -skipnodata -csv "$from/hurs_range.tif" "$dest/hurs_range.csv"
gdal2xyz.py -skipnodata -csv "$from/kg0.tif" "$dest/kg0.csv"
gdal2xyz.py -skipnodata -csv "$from/kg1.tif" "$dest/kg1.csv"
gdal2xyz.py -skipnodata -csv "$from/kg2.tif" "$dest/kg2.csv"
gdal2xyz.py -skipnodata -csv "$from/kg3.tif" "$dest/kg3.csv"
gdal2xyz.py -skipnodata -csv "$from/kg4.tif" "$dest/kg4.csv"
gdal2xyz.py -skipnodata -csv "$from/kg5.tif" "$dest/kg5.csv"
gdal2xyz.py -skipnodata -csv "$from/lgd.tif" "$dest/lgd.csv"
gdal2xyz.py -skipnodata -csv "$from/ngd0.tif" "$dest/ngd0.csv"
gdal2xyz.py -skipnodata -csv "$from/ngd5.tif" "$dest/ngd5.csv"
gdal2xyz.py -skipnodata -csv "$from/ngd10.tif" "$dest/ngd10.csv"
gdal2xyz.py -skipnodata -csv "$from/npp.tif" "$dest/npp.csv"
gdal2xyz.py -skipnodata -csv "$from/pet_penman_max.tif" "$dest/pet_penman_max.csv"
gdal2xyz.py -skipnodata -csv "$from/pet_penman_mean.tif" "$dest/pet_penman_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/pet_penman_min.tif" "$dest/pet_penman_min.csv"
gdal2xyz.py -skipnodata -csv "$from/pet_penman_range.tif" "$dest/pet_penman_range.csv"
gdal2xyz.py -skipnodata -csv "$from/rsds_max.tif" "$dest/rsds_max.csv"
gdal2xyz.py -skipnodata -csv "$from/rsds_mean.tif" "$dest/rsds_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/rsds_min.tif" "$dest/rsds_min.csv"
gdal2xyz.py -skipnodata -csv "$from/rsds_range.tif" "$dest/rsds_range.csv"
gdal2xyz.py -skipnodata -csv "$from/scd.tif" "$dest/scd.csv"
gdal2xyz.py -skipnodata -csv "$from/sfcWind_max.tif" "$dest/sfcWind_max.csv"
gdal2xyz.py -skipnodata -csv "$from/sfcWind_mean.tif" "$dest/sfcWind_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/sfcWind_min.tif" "$dest/sfcWind_min.csv"
gdal2xyz.py -skipnodata -csv "$from/sfcWind_range.tif" "$dest/sfcWind_range.csv"
gdal2xyz.py -skipnodata -csv "$from/swb.tif" "$dest/swb.csv"
gdal2xyz.py -skipnodata -csv "$from/swe.tif" "$dest/swe.csv"
gdal2xyz.py -skipnodata -csv "$from/vpd_max.tif" "$dest/vpd_max.csv"
gdal2xyz.py -skipnodata -csv "$from/vpd_mean.tif" "$dest/vpd_mean.csv"
gdal2xyz.py -skipnodata -csv "$from/vpd_min.tif" "$dest/vpd_min.csv"
gdal2xyz.py -skipnodata -csv "$from/vpd_range.tif" "$dest/vpd_range.csv"

end=$(date +%s)
elapsed=$((end-start))
echo "Elapsed time: $elapsed seconds"
echo "--------------------------------------------------"
