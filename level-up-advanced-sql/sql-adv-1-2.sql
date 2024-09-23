-- 2. Get a list of sales people with zero sales

-- Doesn't sound too difficult?

-- My intuition says we need to do a LEFT JOIN between the employee table and the sales table to see which employees
-- do not have a record in the sales table. Zero sales -> no record in the sales table 

SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	e.title
FROM
	employee AS e
LEFT JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
	
-- Is that it? Let's double check to see if employeeId 3 is in the sales table
SELECT salesId FROM sales WHERE employeeId = 3

-- The employee with employeeId of 3 has made plenty of sales haha. I'm rusty on my LEFT JOINS, I'm missing something..
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	e.title
FROM
	employee AS e
LEFT JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
WHERE
	e.employeeId NOT IN (SELECT DISTINCT employeeId FROM sales ORDER BY employeeId)

-- This gives a more refined subset! Let's double check some of the employees:
SELECT salesId FROM sales WHERE employeeId = 7

-- Ye, that's it. I wish I would be more confident in my answer but this is it. I will be more confident in the
-- future now! That's what I gotta focus on

-- I completely missed to filter for sales people hahaha! Using WHERE salesID IS NULL is also very smart. Final query:
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	e.title,
	e.startDate,
	s.salesId
FROM
	employee AS e
LEFT JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
WHERE
	e.title = 'Sales Person'
	AND s.salesId IS NULL
	
-- Two sales people need more training!