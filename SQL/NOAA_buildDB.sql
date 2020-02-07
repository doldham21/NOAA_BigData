-- Build database to support importing static/fact files from NOAA GHCN-D
-- ghcn- "stations", "states", "countries", "inventory" .txt

----------------------------------------------------------

-- Create staging tables for STATIONS, STATES, COUNTRIES, INVENTORY

-- DROP TABLE STATIONS;
CREATE TABLE STATIONS (
	StationNum VARCHAR(6) PRIMARY KEY NOT NULL,
	StationID CHAR(11) NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longtitude NUMERIC NOT NULL,
	Elevation NUMERIC NOT NULL,
	StationState CHAR(2) NULL,
	StationName VARCHAR(30) NOT NULL,
	GSN_Flag CHAR(3) NULL,
	HCN_CRN_Flag CHAR(3) NULL,
	WMO_ID NUMERIC NULL);
	
-- DROP TABLE STATES;
CREATE TABLE STATES (
	StateNum INTEGER PRIMARY KEY NOT NULL,
	StateAbbr CHAR(2) NOT NULL,
	StateLong VARCHAR(50) NOT NULL);
	
-- DROP TABLE COUNTRIES;
CREATE TABLE COUNTRIES (
	CountryNum INTEGER PRIMARY KEY NOT NULL,
	CountryAbbr CHAR(2) NOT NULL,
	CountryLong VARCHAR(200) NOT NULL);
	
-- DROP TABLE INVENTORY;
CREATE TABLE INVENTORY (
	InventoryNum INTEGER PRIMARY KEY NOT NULL,
	StationID CHAR(11) NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longtitude NUMERIC NOT NULL,
	Element CHAR(4) NOT NULL,
	BeginYear INTEGER,
	EndYear INTEGER);
	
----------------------------------------------------------

-- CSV conversion done in Python: import data into staging tables using COPY
COPY STATIONS FROM '/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-stations.csv' (FORMAT CSV, DELIMITER(','));
COPY STATES FROM '/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-states.csv' (FORMAT CSV, DELIMITER(','));
COPY COUNTRIES FROM '/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-countries.csv' (FORMAT CSV, DELIMITER(','));
COPY INVENTORY FROM '/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-inventory.csv' (FORMAT CSV, DELIMITER(','));


-- Check data was imported properly
SELECT * FROM STATIONS
WHERE stationstate = 'FL'