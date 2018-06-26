#!/bin/bash

GEOJSON_TARGET="germany_1871.geojson"
SHP_SRC="../hayford_test/SDE2_GHGIS1871GERMANY.shp"

SHP_SRC=$1
GEOJSON_TARGET=$2

if [ -f $GEOJSON_TARGET ]; then
  rm $GEOJSON_TARGET;
fi

export SHAPE_ENCODING="ISO-8859-1"
ogr2ogr -f GeoJSON \
  -t_srs EPSG:4326 \
  $GEOJSON_TARGET  \
  $SHP_SRC

# Will be set anyway, generates ogr2ogr warning:
# ... does not support layer creation option ENCODING
#  -lco ENCODING=UTF-8
