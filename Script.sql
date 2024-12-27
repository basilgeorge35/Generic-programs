CREATE TABLE cheese_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);


CREATE TABLE honey_production (
    Year INTEGER,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);


CREATE TABLE milk_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);


CREATE TABLE coffee_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);


CREATE TABLE egg_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);


CREATE TABLE state_lookup (
    State TEXT,
    State_ANSI INTEGER
);


CREATE TABLE yogurt_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);



SELECT * 
FROM milk_production;

SELECT * 
FROM yogurt_production;



PRAGMA table_info(honey_production);

SELECT '[' || name || ']' AS column_name FROM pragma_table_info('cheese_production');
ALTER TABLE cheese_production RENAME COLUMN '    Year' TO Year;
ALTER TABLE cheese_production RENAME COLUMN "    Period" TO Period;
ALTER TABLE cheese_production RENAME COLUMN Geo_Location TO Geo_Level;
ALTER TABLE cheese_production RENAME COLUMN "    State_ANSI" TO State_ANSI;
ALTER TABLE cheese_production RENAME COLUMN Commodity_ANSI TO Commodity_ID;
ALTER TABLE cheese_production RENAME COLUMN "    Domain" TO Domain;
ALTER TABLE cheese_production RENAME COLUMN "    Value" TO Value;


SELECT '[' || name || ']' AS column_name FROM pragma_table_info('coffee_production');
ALTER TABLE coffee_production RENAME COLUMN '    Year' TO Year;
ALTER TABLE coffee_production RENAME COLUMN "    Period" TO Period;
ALTER TABLE coffee_production RENAME COLUMN "    Geo_Level" TO Geo_Level;
ALTER TABLE coffee_production RENAME COLUMN "    State_ANSI" TO State_ANSI;
ALTER TABLE coffee_production RENAME COLUMN "    Commodity_ID" TO Commodity_ID;
--ALTER TABLE coffee_production RENAME COLUMN "    Domain" TO Domain;
ALTER TABLE coffee_production RENAME COLUMN "    Value" TO Value;



SELECT '[' || name || ']' AS column_name FROM pragma_table_info('egg_production');
ALTER TABLE egg_production RENAME COLUMN "    Year" TO Year;
ALTER TABLE egg_production RENAME COLUMN "    Period" TO Period;
ALTER TABLE egg_production RENAME COLUMN "    Geo_Level" TO Geo_Level;
ALTER TABLE egg_production RENAME COLUMN "    State_ANSI" TO State_ANSI;
ALTER TABLE egg_production RENAME COLUMN "    Commodity_ID" TO Commodity_ID;
--ALTER TABLE egg_production RENAME COLUMN "    Domain" TO Domain;
ALTER TABLE egg_production RENAME COLUMN "    Value" TO Value;



SELECT '[' || name || ']' AS column_name FROM pragma_table_info('honey_production');
ALTER TABLE honey_production RENAME COLUMN "    Year" TO Year;
--ALTER TABLE honey_production RENAME COLUMN "    Period" TO Period;
ALTER TABLE honey_production RENAME COLUMN "    Geo_Level" TO Geo_Level;
ALTER TABLE honey_production RENAME COLUMN "    State_ANSI" TO State_ANSI;
ALTER TABLE honey_production RENAME COLUMN "    Commodity_ID" TO Commodity_ID;
--ALTER TABLE honey_production RENAME COLUMN "    Domain" TO Domain;
ALTER TABLE honey_production RENAME COLUMN "    Value" TO Value;



SELECT '[' || name || ']' AS column_name FROM pragma_table_info('milk_production');
ALTER TABLE milk_production RENAME COLUMN "    Year" TO Year;
ALTER TABLE milk_production RENAME COLUMN "    Period" TO Period;
ALTER TABLE milk_production RENAME COLUMN "    Geo_Level" TO Geo_Level;
ALTER TABLE milk_production RENAME COLUMN "    State_ANSI" TO State_ANSI;
ALTER TABLE milk_production RENAME COLUMN "    Commodity_ID" TO Commodity_ID;
ALTER TABLE milk_production RENAME COLUMN "    Domain" TO Domain;
ALTER TABLE milk_production RENAME COLUMN "    Value" TO Value;




SELECT '[' || name || ']' AS column_name FROM pragma_table_info('state_lookup');
ALTER TABLE state_lookup RENAME COLUMN "    State" TO State;
ALTER TABLE state_lookup RENAME COLUMN "    State_ANSI" TO State_ANSI;

SELECT '[' || name || ']' AS column_name FROM pragma_table_info('yogurt_production');
ALTER TABLE yogurt_production RENAME COLUMN "    Year" TO Year;
ALTER TABLE yogurt_production RENAME COLUMN "    Period" TO Period;
ALTER TABLE yogurt_production RENAME COLUMN "    Geo_Level" TO Geo_Level;
ALTER TABLE yogurt_production RENAME COLUMN "    State_ANSI" TO State_ANSI;
ALTER TABLE yogurt_production RENAME COLUMN "    Commodity_ID" TO Commodity_ID;
ALTER TABLE yogurt_production RENAME COLUMN "    Domain" TO Domain;
ALTER TABLE yogurt_production RENAME COLUMN "    Value" TO Value;



UPDATE cheese_production SET value = REPLACE(Value, ',', '');

UPDATE honey_production SET value = REPLACE(value, ',', '');

UPDATE milk_production SET value = REPLACE(value, ',', '');

UPDATE coffee_production SET value = REPLACE(value, ',', '');

UPDATE egg_production SET value = REPLACE(value, ',', '');

UPDATE yogurt_production SET value = REPLACE(value, ',', '');

SELECT * FROM yogurt_production;




-- Find the total milk production for the year 2023.

SELECT * 
FROM milk_production
LIMIT 5
;

SELECT mp.Year, SUM(mp.VALUE)
FROM milk_production mp 
WHERE mp.Year = 2023
GROUP BY mp.Year
;


--Show coffee production data for the year 2015.
--What is the total value?

SELECT * 
FROM coffee_production
LIMIT 5
;

SELECT cp.Year, SUM(cp.VALUE)
FROM coffee_production cp 
WHERE cp.Year = 2015
GROUP BY cp.Year
;


--Find the average honey production for the year 2022.

SELECT * 
FROM honey_production
LIMIT 5
;

SELECT hp.Year, SUM(hp.VALUE), AVG(hp.Value)
FROM honey_production hp 
WHERE hp.Year = 2022
GROUP BY hp.Year
;


--Get the state names with their corresponding ANSI codes from the state_lookup table.
--What number is Iowa?
SELECT *
FROM state_lookup sl 
WHERE sl.State = 'IOWA';

PRAGMA table_info(state_lookup);


--Find the highest yogurt production value for the year 2022.

SELECT MAX(yp.Value)
FROM yogurt_production yp 
WHERE yp."Year" = 2022
;


--Find states where both honey and milk were produced in 2022.
--Did State_ANSI "35" produce both honey and milk in 2022?

SELECT *
FROM honey_production hp;

SELECT *
FROM milk_production mp ;

SELECT mp."Year" MP_YEAR, 
		mp.State_ANSI MP_ANSI, 
		hp.State_ANSI HP_ANSI,
		hp.Value HP_VALUE, 
		mp.Value MP_VALUE
FROM honey_production hp 
JOIN milk_production mp 
	ON hp."Year" = mp."Year" AND hp.State_ANSI = mp.State_ANSI 
WHERE hp."Year" = 2022 AND mp.State_ANSI = 35
;


--Find the total yogurt production for states that also produced cheese in 2022

SELECT SUM(yp.Value)
FROM yogurt_production yp 
JOIN cheese_production cp 
	ON yp."Year" = cp."Year" AND yp.State_ANSI = cp.State_ANSI 
WHERE yp."Year" = 2022
--GROUP BY yp.State_ANSI 
;

SELECT SUM(y.Value)
FROM yogurt_production y
WHERE y.Year = 2022 AND y.State_ANSI IN (
    SELECT DISTINCT c.State_ANSI FROM cheese_production c WHERE c.Year = 2022
);

PRAGMA table_info(yogurt_production);
PRAGMA table_info(cheese_production);


--Can you find out the total milk production for 2023? Your manager wants this information for the yearly report.
--What is the total milk production for 2023?

SELECT SUM(mp.Value)
FROM milk_production mp 
WHERE mp."Year" = 2023
--GROUP BY mp."Year" 
;


--Which states had cheese production greater than 100 million in April 2023? The Cheese Department wants to focus their marketing efforts there. 
--How many states are there?

SELECT *
FROM cheese_production cp 
WHERE cp."Year" = 2023 AND cp.Period = 'APR'
GROUP BY cp.State_ANSI 
HAVING SUM(cp.Value) > 100000000
;


SELECT *
FROM cheese_production cp 
WHERE cp."Year" = 2023 AND cp.Period = 'APR' AND cp.Value > 100000000
--GROUP BY cp.State_ANSI cp.Value) > 100000000
;


--Your manager wants to know how coffee production has changed over the years. 
--What is the total value of coffee production for 2011?

SELECT SUM(cp.Value)
FROM coffee_production cp 
WHERE cp."Year" = 2011
;



--There's a meeting with the Honey Council next week. Find the average honey production for 2022 so you're prepared.

SELECT AVG(hp.Value)
FROM honey_production hp 
WHERE hp."Year" = 2022
;


--The State Relations team wants a list of all states names with their corresponding ANSI codes. Can you generate that list?
--What is the State_ANSI code for Florida?

SELECT *
FROM state_lookup sl 
WHERE sl.State = 'FLORIDA';


--For a cross-commodity report, can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023?
--What is the total for NEW JERSEY?

SELECT sl.State , SUM(cp.Value) Total
--		sl.State_ANSI , cp.State_ANSI , cp."Year" , cp.Period , cp.Value 
FROM state_lookup sl 
LEFT JOIN cheese_production cp 
	ON sl.State_ANSI = cp.State_ANSI 
WHERE sl.State = 'NEW JERSEY' AND cp."Year" = 2023 AND cp.Period = 'APR'
--ORDER BY cp.State_ANSI 
GROUP BY sl.State
--HAVING Total IS NULL 
;


--PRAGMA table_info(cheese_production);
--
SELECT *
FROM state_lookup sl 
WHERE sl.State = 'NEW JERSEY'
;

SELECT *
FROM cheese_production cp
WHERE  cp.State_ANSI = 34 AND cp."Year" = 2023 AND cp.Period = 'APR'
;

--Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? 
--This will help the Dairy Division in their planning.

SELECT SUM(yp.Value)
FROM yogurt_production yp 
WHERE yp."Year" = 2022 AND yp.State_ANSI IN (
								SELECT DISTINCT cp2.State_ANSI
								FROM cheese_production cp2 
								WHERE cp2.Year = 2023
)
;


--List all states from state_lookup that are missing from milk_production in 2023.
--How many states are there?

SELECT COUNT(DISTINCT sl.State_ANSI)
FROM state_lookup sl 
WHERE sl.State_ANSI NOT IN (
							SELECT DISTINCT mp.State_ANSI
							FROM milk_production mp 
							WHERE mp."Year" = 2023
)
;


--List all states with their cheese production values, including states that didn't produce any cheese in April 2023.
--Did Delaware produce any cheese in April 2023?

SELECT *
FROM state_lookup sl 
LEFT JOIN cheese_production cp 
	ON sl.State_ANSI = cp.State_ANSI 
WHERE cp."Year" = 2023 AND cp.Period = 'APR' AND sl.State = 'DELAWARE'
;


--SELECT COUNT(cp.Value) 
--FROM cheese_production cp 
--GROUP BY cp."Year" , cp.Period , cp.State_ANSI 
--HAVING COUNT(cp.Value) > 1


--Find the average coffee production for all years where the honey production exceeded 1 million.

SELECT AVG(cp.Value)
FROM coffee_production cp 
WHERE cp."Year" IN
	(
	SELECT DISTINCT hp."Year" 
	FROM honey_production hp 
	GROUP BY hp."Year" 
	HAVING SUM(hp.Value) > 1000000
	)
;