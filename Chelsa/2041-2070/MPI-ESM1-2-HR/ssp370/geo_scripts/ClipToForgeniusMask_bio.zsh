#!/bin/zsh

###
# Clip bioclimatic variables global TIFF to Forgenius region.
###
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio1_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio01.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio2_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio02.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio3_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio03.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio4_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio04.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio5_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio05.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio6_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio06.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio7_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio07.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio8_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio08.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio9_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio09.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio10_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio10.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio11_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio11.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio12_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio12.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio13_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio13.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio14_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio14.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio15_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio15.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio16_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio16.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio17_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio17.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio18_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio18.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_bio19_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/bio19.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_fcf_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/fcf.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_fgd_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/fgd.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gdd0_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gdd0.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gdd5_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gdd5.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gdd10_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gdd10.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gddlgd0_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gddlgd0.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gddlgd5_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gddlgd5.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gddlgd10_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gddlgd10.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gdgfgd0_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gdgfgd0.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gdgfgd5_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gdgfgd5.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gdgfgd10_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gdgfgd10.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gsl_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gsl.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gsp_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gsp.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_gst_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/gst.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_kg0_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/kg0.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_kg1_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/kg1.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_kg2_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/kg2.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_kg3_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/kg3.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_kg4_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/kg4.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_kg5_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/kg5.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_lgd_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/lgd.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_ngd0_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/ngd0.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_ngd5_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/ngd5.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_ngd10_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/ngd10.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_npp_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/npp.tif"
gdalwarp -overwrite -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_scd_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/scd.tif"
gdalwarp -overwrite -ot Float32 -of GTiff -tr 0.0083333333 -0.0083333333 -tap -cutline "/Users/milko/Local/Data/Environment/ForgeniusRegion/GeoJSON/ForgeniusRegionClipGeoJSON.geojson" -cl ForgeniusRegionClipGeoJSON -crop_to_cutline -dstnodata -999999999.0 -co COMPRESS=DEFLATE -co PREDICTOR=2 -co ZLEVEL=9 "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/Full/bio/CHELSA_swe_2041-2070_mpi-esm1-2-hr_ssp370_V.2.1.tif" "/Users/milko/Local/Data/Environment/Chelsa/2041-2070/MPI-ESM1-2-HR/ssp370/ForgeniusClipped/bio/swe.tif"
