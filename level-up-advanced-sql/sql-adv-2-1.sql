-- 1. Pull a report that totals the number of cars sold by each employee

-- I feel that this calls for some aggregation using COUNT
-- Let's start by joining the employee and sales tables

SELECT
	*
FROM 
	employee AS e
INNER JOIN
	sales AS s
ON
	e.employeeId = s.employeeId

-- Thinking about it, I believe this also needs to include the inventoryId. Indeed it does
SELECT
	e.employeeId,
	e.firstName,
	e.lastName
FROM 
	employee AS e
INNER JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
INNER JOIN
	inventory AS i
ON 
	s.inventoryId = i.inventoryId
GROUP BY
	e.employeeId
ORDER BY
	e.employeeId
	
-- We want somehting like this now with something using COUNT AS cardSold
-- Also hold up, we don't need to join with the inventory table. That would only be relevant if we need specific
-- information about the car sold. That's not the case here, we simply want to count how many times they appear
-- in the sales table to see how many cars they've sold. I assume that every record in the sales table is one
-- car sold. So let's remove the inventory table JOIN:

-- Retroactively now being on 2-3; let's create a VIEW out of this!
CREATE VIEW V_employees_and_car_sales AS
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	COUNT(*) AS carsSold
FROM 
	employee AS e
INNER JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
GROUP BY
	e.employeeId
	
CREATE VIEW V_employees_and_car_sales_2023 AS
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	COUNT(*) AS carsSold
FROM 
	employee AS e
INNER JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
WHERE
	s.soldDate BETWEEN DATE('2023-01-01') AND DATE('2023-12-31')
GROUP BY
	e.employeeId
	
-- That's it!
-- The brief mentions NOTHING about ordering by number of cars sold with the most at the top but since she does
-- it in the solution video, let's do it as well:
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	COUNT(*) AS carsSold
FROM 
	employee AS e
INNER JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
GROUP BY
	e.employeeId --, e.firstName, e.lastName Not neccessary to have these two others in the GROUP BY since employeeId is unique
ORDER BY
	carsSold DESC;
