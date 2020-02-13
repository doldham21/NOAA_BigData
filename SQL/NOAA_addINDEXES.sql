-- Implement indexes on NOAA DB

CREATE INDEX stations_idx1
ON STATIONS(StationID);

CREATE INDEX inventory_idx1
ON INVENTORY(StationID);

CREATE INDEX obs_idx1
ON OBS(StationID);