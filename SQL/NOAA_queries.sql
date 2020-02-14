-- Query database as desired

-- Join Stations, Countries, States
SELECT obsnum, stationid, stationname, year, month, element, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, StateLong, CountryLong 
FROM OBS
JOIN Stations USING(StationID)
JOIN States USING(StateAbbr)
JOIN Countries USING(CountryAbbr)
--WHERE Element = 'TMAX' OR Element = 'TMIN'
ORDER BY year;