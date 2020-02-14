-- Create average columns for full months where data is available

-- Find average MAX TEMP for a certain state depending on month (30 or 31 days - ignoring february for now)
(
SELECT stationid, stationname, statelong, month, year,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/310) AS TMAX_Month_AVG_C
FROM obs
INNER JOIN Stations USING(StationID)
INNER JOIN States USING(StateAbbr)
WHERE Element IN('TMAX')
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/310) IS NOT NULL
	AND month IN(1,3,5,7,8,10,12)
	AND StateAbbr = 'FL'
)
	
UNION

(
SELECT stationid, stationname, statelong, month, year,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30)/300) AS TMAX_Month_AVG_C
FROM obs
INNER JOIN Stations USING(StationID)
INNER JOIN States USING(StateAbbr)
WHERE Element IN('TMAX')
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30)/300) IS NOT NULL
	AND month IN(4,6,9,11)
	AND StateAbbr = 'FL'
)

ORDER BY stationid, year, month