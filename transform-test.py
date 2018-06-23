
import time
import json


# Funktion zur umwandlung der Breitengrade
# R-lineare funktion:
# intercept: -0.108789    Steigung: 0.002446
def transform_lat(x_val):
    return x_val + (-0.108789 + (x_val * 0.002446))

# Funktion zur umwandlung der Breitengrade
# R-lineare funktion:
# intercept: -0.0227280    Steigung: 0.0007187
def transform_lon(y_val):
    return y_val + (-0.0227280 + (y_val * 0.0007187))
    # return y_val


with open("germany_1871.geojson") as fh:
    germany = json.load(fh)

for feature in germany["features"]:
    print(feature["properties"])
    for multipoly in feature["geometry"]["coordinates"]:
        for poly in multipoly:
                print("Is list")
                print(poly)
                for coords_idx, coords in enumerate(poly):
                    if isinstance(coords, list):
                        print(80 * "#")
                        print(coords)
                        coords[0] = transform_lon(coords[0])
                        coords[1] = transform_lat(coords[1])
                        print(coords)
                    elif isinstance(coords, float):
                        if coords_idx == 0:
                            coords = transform_lon(coords)
                        else:
                            coords = transform_lat(coords)
                            
geojson_name = "germany_1871_transformed_" + str(int(time.time())) + ".geojson"

with open(geojson_name, "w+") as fh_out:
    json.dump(germany, fh_out)
