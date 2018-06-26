
import time
import json
import yaml
import sys


# Returns tuple (intercept, steigung)
def read_linear_params(file_path):
    with open(file_path) as fh:
        coeff_config = yaml.load(fh)
        intercept = coeff_config[0]
        coefficient = coeff_config[1]
    return (intercept, coefficient)


# Funktion zur umwandlung der Breitengrade
# R-lineare funktion:
# intercept: -0.108789    Steigung: 0.002446
def transform_coord(x_val, params):
    return x_val + (params[0] + (x_val * params[1]))


# Recursive function to transform single coordinates
def recursive_coord_transform(geo_object, lon_params, lat_params):

    if len(geo_object) == 2 and isinstance(geo_object[0], float):
        geo_object[0] = transform_coord(geo_object[0], lon_params)
        geo_object[1] = transform_coord(geo_object[1], lon_params)
    else:
        for sub_object in geo_object:
            recursive_coord_transform(sub_object, lon_params, lat_params)


if len(sys.argv) != 3:
    print("USAGE: python3 transform-coords.py input_file output_file")
lat_params = read_linear_params("coeff-linear-sn.yaml")
lon_params = read_linear_params("coeff-linear-we.yaml")


with open(sys.argv[1]) as fh:
    germany = json.load(fh)

feature_count = []

for feature in germany["features"]:
    recursive_coord_transform(
        feature["geometry"]["coordinates"],
        lon_params,
        lat_params
    )
        # for poly in multipoly:
        #         for coords_idx, coords in enumerate(poly):
        #             if isinstance(coords, list):
        #                 coords[0] = transform_coord(coords[0], lon_params)
        #                 coords[1] = transform_coord(coords[1], lat_params)
        #             elif isinstance(coords, float):
        #                 if coords_idx == 0:
        #                     coords = transform_coord(coords, lon_params)
        #                 else:
        #                     coords = transform_coord(coords, lat_params)

# geojson_name = "germany_1871_transformed_" + str(int(time.time())) + ".geojson"

with open(sys.argv[2], "w+") as fh_out:
    json.dump(germany, fh_out)
