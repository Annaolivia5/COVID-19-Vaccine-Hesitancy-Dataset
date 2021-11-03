-- Run queries to create vaccine_data and census_data before running pandas code.

CREATE TABLE vaccine_data(
	vaccine_id SERIAL PRIMARY KEY,
	county_name TEXT,
	state TEXT,
	est_hesitant FLOAT, 
	est_strongly_hesitant FLOAT, 
	svi FLOAT,
    cvac_level_of_concern_rollout FLOAT, 
	percent_adults_fully_vaccinated FLOAT
);

CREATE TABLE census_data (
	census_id SERIAL PRIMARY KEY,
	state TEXT,
	county TEXT,
	total_pop INTEGER,
	income INTEGER,
	income_err FLOAT,
	income_per_cap INTEGER,
	income_per_cap_err INTEGER,
	poverty FLOAT,
	unemployment FLOAT
);

-- After tables are created and data inserted from pandas.
-- the following queries will merge the data into one table.

ALTER TABLE vaccine_data 
RENAME COLUMN state TO state_v;

CREATE TABLE census_vaccine_data AS(
	SELECT *
	FROM census_data
	INNER JOIN vaccine_data ON
	census_data.county = vaccine_data.county_name
	AND vaccine_data.state_v = census_data.state
	order by vaccine_data.county_name);

ALTER TABLE census_vaccine_data
    DROP COLUMN county_name,
    DROP COLUMN state_v,
	DROP COLUMN vaccine_id,
	DROP COLUMN census_id;

drop table census_vaccine_data;
drop table census_data;
drop table vaccine_data;
SELECT * FROM census_vaccine_data;

