# README

Berechne für alle korrektur-Linien die Abweichung nach
Norden und Westen

## Postgres

Datenbankname: hgis_corrections
Table-Name: korrektur_linien

Load-Command:

~~~
shp2pgsql -d ../korrektur_linien.shp korrektur_linien | psql hgis_correction
~~~

## Python

`compute_wgs_offset.py` Berechnet die Distanz auf beiden Achsen in
latlon und schreibt sie in die csv-Dateien

## R

Skript `plot_offset.R` plottet die csv Dateien als scatterplot und
zeichnet eine lineare regressions-linie 
