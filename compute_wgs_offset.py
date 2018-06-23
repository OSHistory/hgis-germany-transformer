
import csv
import re

import psycopg2

conn = psycopg2.connect(database="hgis_correction", user="americo")
print(conn)

curs = conn.cursor()
print(curs)
curs.execute("""SELECT ST_AsText(geom) FROM korrektur_linien""")
results = curs.fetchall()
print(results)

float_vals = []
for row in results:
    floats = re.findall("\d*\.\d*", row[0])
    floats = [float(num) for num in floats]
    float_vals.append(floats)

with open("dist_vals_sn.csv", "w+") as fh_out:
    writer = csv.writer(fh_out)
    for floats in float_vals:
        dist = floats[3] - floats[1]
        writer.writerow([floats[1], dist])

with open("dist_vals_we.csv", "w+") as fh_out:
    writer = csv.writer(fh_out)
    for floats in float_vals:
        dist = floats[2] - floats[0]
        writer.writerow([floats[0], dist])
