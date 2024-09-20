/*
Created by: Steven Lomon Lennartsson
Create date: 9/18/2024

FUNCTIONS
How many customers do we have whose last name starts with S?
*/

/*
SELECT
	COUNT(*) AS 'Customers with last name starting with S'
FROM
	Customer AS c
WHERE
	LastName LIKE 'S%'
*/

-- Calculate the age of every Employee
/*SELECT 
	FirstName,
	LastName,
	-- CURRENT_DATE,
	-- strftime('%Y-%m-%d', 'now'),
	CURRENT_DATE - DATE(BirthDate) AS Age
FROM
	Employee
*/

-- AGGREGATE FUNCTIONS: What are our all time global sales?
SELECT 
	SUM(total) AS 'Total sales',
	ROUND(AVG(total), 2) AS 'Average sales', -- Nesting functions!
	MAX(total) AS 'Maximum sale',
	MIN(total) AS 'Minimum sale',
	COUNT(*) AS 'Sales count'
FROM
	Invoice AS i
