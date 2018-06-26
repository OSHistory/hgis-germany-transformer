# README

Das Repository bietet eine automatisierte und reproduzierbare
KOrrektur des HGIS Datensatzes, der insbesondere nach Norden und
Westen unterschiedlich stark verschoben ist.

Das repository ist auf ein Linux-Betriebssystem mit folgenden
Abhängigkeiten ausgelegt:
  - Python3
  - R
  - ogr2ogr

## Daten

Die Daten befinden sich nicht im repository. Sie müssen separat
heruntergeladen werden. Der
[Link](http://hgisg.i3mainz.hs-mainz.de/intro/hgisg_check.php)
befindet sich auf der HGIS-Website.

Die Daten sollten in `data/` abgelegt werden.

## Toolchain

Zentrale Datei ist `run-coord-shift`. Er kombiniert mehrere
Einzelskripte. Argumente sind input und output-file (muss
geojson sein).

`bash run-coord-shift data/original.shp /tmp/mein-test.geojson`


### Schritt 1: Abweichung berechnen (Python)

`compute_wgs_offset.py` Berechnet die Distanz auf beiden Achsen in
latlon und schreibt sie in die csv-Dateien

### Schritt 2: Abweichung darstellen und lineare Funktion berechnen (R)

Skript `plot_offset.R` plottet die csv Dateien als scatterplot und
berechnet, zeichnet und speichert eine lineare regressions-linie

### Schritt 3: Koordinaten umrechnen

`transform-coords.py` iteriert über alle features und berechnet einen
neuen Wert mit der in Schritt 2 berechneten Linearen funktion.

## Batch-Mode

Der Skript `transform_all_files_to_gpkg.sh` iteriert über alle
shp-Dateien im Data-Ordner (`data/`) und generiert eine einzelne
GeoPackage-Datei.
