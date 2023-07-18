#!/bin/zsh

###
# Append individual variables in temp_pong.
###
for name in ai bio1 bio2 bio3 bio4 bio5 bio6 bio7 bio8 bio9 bio10 bio11 bio12 bio13 bio14 bio15 bio16 bio17 bio18 bio19 cmi_max cmi_mean cmi_min cmi_range fcf fgd gdd0 gdd5 gdd10 gddlgd0 gddlgd5 gddlgd10 gdgfgd0 gdgfgd5 gdgfgd10 gsl gsp gst hurs_max hurs_mean hurs_min hurs_range kg0 kg1 kg2 kg3 kg4 kg5 lgd ngd0 ngd5 ngd10 npp pet_penman_max pet_penman_mean pet_penman_min pet_penman_range rsds_max rsds_mean rsds_min rsds_range scd sfcWind_max sfcWind_mean sfcWind_min sfcWind_range swe vpd_mean vpd_min vpd_max vpd_range
do
	echo ""
	echo "==> $name"
	arangoimport \
			--server.endpoint "http+tcp://127.0.0.1:8529" \
			--server.database "Chelsa" \
			--server.username "root" \
			--server.password "7YHMchHC8VjxcGnCyhsL9nuA" \
			--file "/Users/milko/Local/Data/Environment/Chelsa/1981-2010/CSV/bio/$name.csv" \
			--headers-file /Users/milko/Local/Data/Environment/Chelsa/config/header.csv \
			--type "csv" \
			--collection temp_pong \
			--translate "value=env_$name" \
			--ignore-missing
done
