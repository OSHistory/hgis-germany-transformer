#!/bin/bash

python3 compute_wgs_offset.py
Rscript --vanilla plot_offset.R 
python3 transform-coords.py
