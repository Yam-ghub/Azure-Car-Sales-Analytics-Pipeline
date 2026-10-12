-- Create a table to store the last loaded date_id (watermark)
CREATE TABLE water_table
(
    last_load VARCHAR(2000)
)

SELECT * FROM water_table

-- get the lowest date_id
SELECT min(date_id) FROM dbo.source_cars_data

-- Initialize the last_load column with a value lower than the earliest date_id
-- This allows the initial load to include all source records
INSERT INTO water_table (last_load)
VALUES('DT00000')

-- Validate the number of records eligible for loading
-- Compare the filtered count against the total source record count
SELECT COUNT(*) FROM dbo.source_cars_data where date_id > 'DT00000'
SELECT COUNT(*) FROM dbo.source_cars_data

-- validate data
SELECT * FROM dbo.source_cars_data where date_id > 'DT00000'
