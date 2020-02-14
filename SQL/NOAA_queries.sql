-- Query database as desired

-- Join Stations, Countries, States
SELECT obsnum, stationid, stationname, year, month, element, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, StateLong, CountryLong 
FROM OBS
JOIN Stations USING(StationID)
JOIN States USING(StateAbbr)
JOIN Countries USING(CountryAbbr)
WHERE Element = 'TMAX' OR Element = 'TMIN'
ORDER BY obsnum
LIMIT 10000;


-- Find TMAX and TMIN information for certain state
SELECT obsnum, stationid, stationname, year, month, element, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, StateAbbr, StateLong, CountryLong 
FROM OBS
JOIN Stations USING(StationID)
JOIN States USING(StateAbbr)
JOIN Countries USING(CountryAbbr)
WHERE Element IN('TMAX','TMIN') AND StateAbbr = 'FL'
ORDER BY year DESC
LIMIT 2000;