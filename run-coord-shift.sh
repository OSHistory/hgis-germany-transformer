#!/bin/bash

# TODO:
# Make script executable from anywhere

if [ $# -ne 2 ]; then
  echo "USAGE: run-coord-shift.sh input_file output_file";
fi

input_file=$1
output_file=$2

geojson_tmp="/tmp/"$(basename $1)".geojson"

bash create-geojson.sh $input_file $geojson_tmp
#ogr2ogr -f GeoJSON $geojson_tmp $input_file
python3 compute_wgs_offset.py
Rscript --vanilla plot_offset.R > /dev/null
python3 transform-coords.py $geojson_tmp $output_file
