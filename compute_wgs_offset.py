
# Computes the offsets for south-north and east-west direction
# from an postgis-database

import csv
import json

with open("korrektur-linien.geojson") as fh:
    korrektur_linien = json.load(fh)

float_vals = []
for feature in korrektur_linien["features"]:
    float_vals.append(feature["geometry"]["coordinates"])

with open("dist_vals_sn.csv", "w+") as fh_out:
    writer = csv.writer(fh_out)
    for floats in float_vals:
        dist = floats[1][1] - floats[0][1]
        writer.writerow([floats[1][1], dist])

with open("dist_vals_we.csv", "w+") as fh_out:
    writer = csv.writer(fh_out)
    for floats in float_vals:
        dist = floats[1][0] - floats[0][0]
        writer.writerow([floats[1][0], dist])
