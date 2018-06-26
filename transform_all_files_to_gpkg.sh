#!/bin/bash

DATA_DIR="data/"
GPKG_FILE="hgis-germany.gpkg"

if [ ! -d "transformed" ]; then
	mkdir "transformed"
fi

# skip append option for first sh
first_geo_file=1

for shp in $(find $DATA_DIR -name "*shp"); do
	echo $shp;
	geo_basename=$(basename ${shp%%.shp})
	out_file="./transformed/"$geo_basename".geojson"
	# Check for patterns to exclude (no transform)
	matches=$(echo $geo_basename | grep -E "Eisenbahnen|CAPS|CAPITAL" | wc -l)
	if [ $matches -gt 0 ]; then
		# no transform, just reprojection
		bash create-geojson.sh $shp $out_file
	else
		# transform the coordinates
		bash run-coord-shift.sh $shp $out_file
	fi

	GPKG_OPTS=""
	if [ $first_geo_file -eq 0 ]; then
		GPKG_OPTS="-append"
	else
		first_geo_file=0
	fi
	ogr2ogr -f GPKG $GPKG_OPTS $GPKG_FILE $out_file

done

cd ../
