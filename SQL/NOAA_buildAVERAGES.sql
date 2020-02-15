-- Create average columns for full months where data is available

-- Find average MAX TEMP for a certain state depending on month (30 or 31 days - ignoring february for now)

WITH 
average_CTE AS 
(

-- 31 day months
(
SELECT stationid, stateabbr, month, year,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/31) AS TMAX_Month_AVG_C
FROM obs
WHERE Element IN('TMAX')
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/31) IS NOT NULL
	AND month IN(1,3,5,7,8,10,12)
	AND StateAbbr = 'FL'
	--AND CountryAbbr = 'US'
)
	
UNION ALL

-- 30 day months
(
SELECT stationid, stateabbr, month, year,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30)/30) AS TMAX_Month_AVG_C
FROM obs
WHERE Element IN('TMAX')
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30)/30) IS NOT NULL
	AND month IN(4,6,9,11)
	AND StateAbbr = 'FL'
	--AND CountryAbbr = 'US'
)
	
UNION ALL

-- February, 28 days, NOT leap years
(
SELECT stationid, stateabbr, month, year,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/28) AS TMAX_Month_AVG_C
FROM obs
WHERE Element IN('TMAX')
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/28) IS NOT NULL
	AND month IN(2)
	AND year NOT IN(1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 
					1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964, 
					1968, 1972, 1976, 1980, 1984, 1988, 1992, 1996, 
					2000, 2004, 2008, 2012, 2016, 2020)
	AND StateAbbr = 'FL'
	--AND CountryAbbr = 'US'
)
	
UNION ALL

-- February, 29 days, leap years
(
SELECT stationid, stateabbr, month, year,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/29) AS TMAX_Month_AVG_C
FROM obs
WHERE Element IN('TMAX')
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/29) IS NOT NULL
	AND month IN(2)
	AND year IN(1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 
					1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964, 
					1968, 1972, 1976, 1980, 1984, 1988, 1992, 1996, 
					2000, 2004, 2008, 2012, 2016, 2020)
	AND StateAbbr = 'FL'
	--AND CountryAbbr = 'US'
)

--ORDER BY stationid, year, month
	
),


-- Note that as of making this script 2020 just started, so only using past data

permonth_CTE AS
(
-- Averages per month
SELECT month, year, COUNT(DISTINCT(month)) AS nummonths, 
		AVG(tmax_month_avg_c) AS tmax_average_monthly
FROM average_CTE
GROUP BY month, year
--ORDER BY year, month
),

peryear_CTE AS
(
-- Per year averages, all stations
-- Logic is correct: isolating one year to one month in permonth_CTE
-- lets me count the number of times that year appears as the number of months
SELECT year, AVG(tmax_average_monthly) AS tmax_average_yearly, 
		COUNT(year) AS num_months
FROM permonth_CTE
GROUP BY year
--ORDER BY year
)

-- Only use data that has a full 12-month average
-- Convert to C, not tenths of C
SELECT year, (tmax_average_yearly/10) AS tmax_yearly FROM peryear_CTE
WHERE num_months = 12
ORDER BY year;


