# -*- coding: utf-8 -*-
"""
Convert raw NOAA .txt files to .csv to easily import into Postgres
"""

import pandas as pd

# Stations data
# Read based on fixed-width format
stations = pd.read_fwf('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/text_files/ghcnd-stations.txt',
                widths=[12,9,9,7,3,31,4,4,5], header=None)

# Convert to csv for PG import
stations.to_csv('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-stations.csv',
                   sep=',', encoding='utf-8', header=None)


# States data
states = pd.read_fwf('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/text_files/ghcnd-states.txt',
                widths=[3,35], header=None)

# Convert to csv for PG import
states.to_csv('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-states.csv',
                   sep=',', encoding='utf-8', header=None)


# Countries data
countries = pd.read_fwf('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/text_files/ghcnd-countries.txt',
                widths=[3,200], header=None)

# Convert to csv for PG import
countries.to_csv('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-countries.csv',
                   sep=',', encoding='utf-8', header=None)