SELECT * 
FROM parks_and_recreation.employee_demographics
WHERE (gender = 'Male' AND age < 40) OR first_name LIKE 'A%'
;


SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 50000
;

SELECT * 
FROM parks_and_recreation.employee_salary
ORDER BY salary DESC
LIMIT 2, 3
# 3 rows after the first 2 rowns 
;

SELECT dem.employee_id, dem.first_name, dem.last_name, dem.age, sal.salary
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
WHERE sal.salary > 50000
;

SELECT dem.employee_id, dem.first_name, dem.last_name, dem.age, sal.salary
FROM parks_and_recreation.employee_demographics AS dem
LEFT JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
WHERE sal.salary > 50000
;

SELECT sal.employee_id, sal.first_name, sal.last_name, dem.age, sal.salary
FROM parks_and_recreation.employee_demographics AS dem
RIGHT JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
WHERE sal.salary > 50000
;



SELECT *
FROM parks_and_recreation.employee_demographics AS dem1
JOIN parks_and_recreation.employee_demographics AS dem2
	ON dem1.employee_id = dem2.employee_id + 1
;

SELECT *
FROM parks_and_recreation.parks_departments
;

SELECT dem.employee_id, dem.first_name, dem.last_name, dem.age, sal.salary, dep.department_name
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_and_recreation.parks_departments AS dep
	ON sal.dept_id = dep.department_id
WHERE sal.salary > 50000 AND age < 40
;


SELECT first_name, last_name, 'Old' AS Label
FROM parks_and_recreation.employee_demographics
WHERE age > 40
UNION ALL
SELECT first_name, last_name, 'Highly Paid' AS Label
FROM parks_and_recreation.employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;

SELECT first_name, last_name, birth_date,
SUBSTRING(birth_date, 6, 2) AS month_born
FROM parks_and_recreation.employee_demographics
;

SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM parks_and_recreation.employee_demographics
;


SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.10
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
END AS Bonus
FROM parks_and_recreation.employee_salary
;


SELECT employee_id, first_name, last_name, salary
FROM parks_and_recreation.employee_salary
;

SELECT *
FROM parks_and_recreation.parks_departments
WHERE department_name = 'parks and recreation';

SELECT * 
FROM parks_and_recreation.employee_salary
WHERE dept_id IN ( SELECT department_id 
					FROM parks_and_recreation.parks_departments
					WHERE department_name = 'parks and recreation'
)
;

SELECT first_name, last_name, salary, 
( SELECT AVG(salary)
FROM parks_and_recreation.employee_salary
) AS Average_Salary
FROM parks_and_recreation.employee_salary
;

SELECT gender, MAX(age) AS max_age , MIN(age) AS min_age, COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT AVG(max_age), AVG(min_age)
FROM(
	SELECT gender, MAX(age) AS max_age , MIN(age) AS min_age, COUNT(age)
	FROM parks_and_recreation.employee_demographics
	GROUP BY gender
) AS agg_table
;

SELECT dem.gender, AVG(sal.salary)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.gender
;

SELECT dem.first_name, dem.gender, AVG(sal.salary) OVER(PARTITION BY dem.gender)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.first_name, dem.gender, sal.salary,
	SUM(sal.salary) OVER(PARTITION BY dem.gender ORDER BY dem.employee_id) AS rolling_total
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.first_name, dem.gender, sal.salary,
ROW_NUMBER() OVER(PARTITION BY dem.gender ORDER BY sal.salary) AS row_num,
RANK() OVER(PARTITION BY dem.gender ORDER BY sal.salary) AS rank_num,
DENSE_RANK() OVER(PARTITION BY dem.gender ORDER BY sal.salary) AS dense_rank_num
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- CTE
WITH CTE_Example (GENDER, AVG_SALARY) AS (
SELECT dem.gender, AVG(sal.salary)
FROM parks_and_recreation.employee_demographics dem
JOIN parks_and_recreation.employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.gender
)
SELECT *
FROM CTE_Example
;

WITH CTE_1 AS (
SELECT employee_id, first_name, last_name, age
FROM parks_and_recreation.employee_demographics
WHERE age > 40
),
CTE_2 AS (
SELECT employee_id, first_name, last_name, salary
FROM parks_and_recreation.employee_salary
WHERE salary > 50000
)
SELECT CTE_1.employee_id, CTE_1.first_name, CTE_1.last_name, CTE_2.salary, CTE_1.age
FROM CTE_1
LEFT OUTER JOIN CTE_2
	ON CTE_1.employee_id = CTE_2.employee_id
UNION	-- Doing full outer join using UNION
SELECT CTE_2.employee_id, CTE_2.first_name, CTE_2.last_name, CTE_2.salary, CTE_1.age
FROM CTE_1
RIGHT OUTER JOIN CTE_2
	ON CTE_1.employee_id = CTE_2.employee_id
;


WITH CTE_1 AS (
SELECT employee_id, first_name, last_name, age
FROM parks_and_recreation.employee_demographics
WHERE age > 40
),
CTE_2 AS (
SELECT employee_id, salary
FROM parks_and_recreation.employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_1
JOIN CTE_2	-- Inner join
	ON CTE_1.employee_id = CTE_2.employee_id
;

-- Temp Tables

CREATE TEMPORARY TABLE temp_table
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary > 50000
;

SELECT * 
FROM temp_table;

USE parks_and_recreation -- not mandatory
DELIMITER $$
CREATE PROCEDURE old_age()
BEGIN
	SELECT *
    FROM parks_and_recreation.employee_demographics
	WHERE age > 50;
    SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary > 50000;
END $$
DELIMITER ;

CALL old_age();

DELIMITER $$
CREATE PROCEDURE get_details(employee_id_param INT)
BEGIN
	SELECT * 
    FROM parks_and_recreation.employee_demographics
    WHERE employee_id = employee_id_param;
END $$
DELIMITER ;

CALL get_details(3);

-- Triggers

DELIMITER $$
CREATE TRIGGER employee_update
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(14, 'John', 'Snow', 'Team Leader', 60000, NULL);

SELECT * 
FROM employee_demographics ;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age > 60;
END $$
DELIMITER ;