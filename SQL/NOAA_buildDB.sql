-- Build database to support querying NOAA GHCN-D

-- DROP TABLE STATIONS;
-- Create table for ghcnd-stations.txt
CREATE TABLE STATIONS (
	StationNum INTEGER PRIMARY KEY NOT NULL,
	StationID CHAR(11) NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longtitude NUMERIC NOT NULL,
	Elevation NUMERIC NOT NULL,
	StationState CHAR(2) NULL,
	StationName VARCHAR(30) NOT NULL,
	GSN_Flag CHAR(3) NULL,
	HCN_CRN_Flag CHAR(3) NULL,
	WMO_ID VARCHAR(5) NULL);

-- Credit for csv conversion:
-- spatialreasoning.com/wp/20170307_1244_r-reading-filtering-weather-data-from-the-global-historical-climatology-network-ghcn

-- Import data from .csv file for station information
COPY STATIONS FROM '/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-stations.csv' (FORMAT CSV, HEADER, DELIMITER(','));

-- Check data was imported properly
SELECT * FROM STATIONS
WHERE stationstate = 'AK'