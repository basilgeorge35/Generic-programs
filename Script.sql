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