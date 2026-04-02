drop table if exists restaurant_ispections;`

CREATE TABLE restaurant_inspections(
camis BIGINT,
    dba TEXT,
    boro VARCHAR(50),
    building VARCHAR(20),
    street TEXT,
    zipcode VARCHAR(10),
    phone VARCHAR(20),
    cuisine_description TEXT,
    inspection_date DATE,
    action TEXT,
    violation_code VARCHAR(10),
    violation_description TEXT,
    critical_flag VARCHAR(10),
    score INTEGER,
    grade VARCHAR(5),
    grade_date DATE,
    record_date DATE,
    inspection_type TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    community_board INTEGER,
    council_district INTEGER,
    census_tract DOUBLE PRECISION,
    bin BIGINT,
    bbl DOUBLE PRECISION,
    nta VARCHAR(10)
);

-- Identify missing data 
SELECT *
FROM restaurant_inspections
WHERE score IS NULL;

-- number of record of missing data (How many restaurant_inspections records have a NULL value for score column?)
SELECT
	COUNT(*)
FROM 
restaurant_inspections
WHERE score IS NULL;

-- Count missing data for each column separately
SELECT 'camis', COUNT(*) FROM restaurant_inspections WHERE camis IS NULL
UNION ALL
SELECT 'dba', COUNT(*) FROM restaurant_inspections WHERE dba IS NULL
UNION ALL
SELECT 'boro', COUNT(*) FROM restaurant_inspections WHERE boro IS NULL
UNION ALL
SELECT 'building', COUNT(*) FROM restaurant_inspections WHERE building IS NULL
UNION ALL 
SELECT 'score', COUNT(*) FROM restaurant_inspections WHERE score IS NULL;

-- UNION ALL is used to stack multiple result sets vertically (row by row) rather than horizontally
-- CASE statement = Horizontal stacking (columns) - good for wide-format data

`-- investigate relationships between colums using missing data by counting null records in one column while grouping by values in another` 
SELECT 
	inspection_type,
	COUNT(*) AS count
FROM restaurant_inspections
WHERE score IS NULL
GROUP BY inspection_type
ORDER BY count DESC;

-- Rectifying missing data 
-- best option locate and add missing values 
-- provide a value (average, median etc)
-- exclude records (last resort)
-- replacing values with COALESCE()

-- Incase we wanna replace -1 instead of NULL score we can use COALESCE()
SELECT 
	COALESCE(score, -1),
	inspection_type
FROM restaurant_inspections;

-- using a fill in value 
-- Use COALESCE() to replace any dba that is NULL with the string value UNKNOWN in the restaurant_inspections table.
UPDATE restaurant_inspections
SET 
	dba = COALESCE(dba, 'UNKNOWN'); 
SELECT COUNT(*) FROM restaurant_inspections WHERE dba = 'UNKNOWN';
