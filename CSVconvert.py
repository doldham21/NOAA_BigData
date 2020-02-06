# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd

# Stations data
stations = pd.read_fwf('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/text_files/ghcnd-stations.txt',
                widths=[12,10,9,10,31,4,4,5], header=None)

stations.to_csv('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-stations.csv',
                   sep=',', encoding='utf-8')

