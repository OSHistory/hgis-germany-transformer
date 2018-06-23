#!/bin/bash

GEOJSON_TARGET="germany_1871.geojson"

if [ -f $GEOJSON_TARGET ]; then
  rm $GEOJSON_TARGET;
fi

export SHAPE_ENCODING="ISO-8859-1"
ogr2ogr -f GeoJSON \
  -t_srs EPSG:4326 \
  $GEOJSON_TARGET  \
  ../hayford_test/SDE2_GHGIS1871GERMANY.shp  \
  -lco ENCODING=UTF-8
