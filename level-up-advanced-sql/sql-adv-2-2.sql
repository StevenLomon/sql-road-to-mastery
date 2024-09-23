-- 2. Produce a report that lists the least and most expensive car sold by each employee this year

-- I feel this calls for the MIN() and MAX() aggregate functions
-- It isn't perfectly clear from the description brief whether or not we want actual information about the cars
-- sold or just the sales amount. Let's add it just for the practice of it

SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	MIN(s.salesAmount) AS leastExpensive,
	m.model,
	i.colour,
	MAX(s.salesAmount) AS mostExpensive,
	m.model
FROM
	employee AS e
INNER JOIN sales AS s ON e.employeeId = s.employeeId
INNER JOIN inventory AS i ON s.inventoryId = i.inventoryId
INNER JOIN model AS m ON i.modelId = m.modelId -- Single line INNER JOINS since more than one JOIN
GROUP BY
	e.employeeId

-- This is interesting.. The model and the colour I've produced, is it for the least expensive or most expensive??
-- I wanna look in the video if she includes car info
-- No, she only includes the min and max sales amounts. Let's do that as well and let's not forget the "this year"
-- requirement. And let's have "this year" be 2023:

SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	MIN(s.salesAmount) AS leastExpensive,
	MAX(s.salesAmount) AS mostExpensive
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
	
-- Updated using DATE('now', 'start of year') which is super nifty and useful!
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	MIN(s.salesAmount) AS leastExpensive,
	MAX(s.salesAmount) AS mostExpensive
FROM
	employee AS e
INNER JOIN 
	sales AS s 
ON 
	e.employeeId = s.employeeId
WHERE
	s.soldDate >= date('now', 'start of year')
GROUP BY
	e.employeeId

-- Let's add a sales now for 2024 and double check to see if this works:
INSERT INTO sales 
	(inventoryId, customerId, employeeId, salesAmount, soldDate) 
VALUES
	(104, 177, 57, 46058.99, '2024-09-23 00:00:00')
	
-- Running the query again now gives the row we just inserted!

-- Now let's have ChatGPT help us to filter by 2023 and display car model and colour for the least expensive
-- car sold and most expensive car sold. Building on this query:
SELECT
	e.employeeId,
	e.firstName,
	e.lastName,
	MIN(s.salesAmount) AS leastExpensive,
	m.model,
	i.colour,
	MAX(s.salesAmount) AS mostExpensive,
	m.model,
	i.colour
FROM
	employee AS e
INNER JOIN sales AS s ON e.employeeId = s.employeeId
INNER JOIN inventory AS i ON s.inventoryId = i.inventoryId
INNER JOIN model AS m ON i.modelId = m.modelId -- Single line INNER JOINS since more than one JOIN
WHERE
	s.soldDate BETWEEN DATE('2023-01-01') AND DATE('2023-12-31')
GROUP BY
	e.employeeId;
	
-- On most rows the leastExpensive and mostExpensive are the same but on row 5 they do differ but
-- the model and colour are the same. Let's fix this now:

/* "To get the specific model and color for the least expensive and the most expensive car sold by 
each employee, you'll need to split the logic into two parts: one for the least expensive car and 
one for the most expensive car, and then combine them." */
-- This makes a lot of sense
-- This is a monstrous query in size but let's write it haha!
WITH LeastExpensiveCars AS (
	SELECT
		e.employeeId,
		e.firstName,
		e.lastName,
		MIN(s.salesAmount) AS leastExpensive,
		m.model AS leastExpensiveModel,
		i.colour AS leastExpensiveColour
	FROM
		employee AS e
	INNER JOIN sales AS s ON e.employeeId = s.employeeId
	INNER JOIN inventory AS i ON s.inventoryId = i.inventoryId
	INNER JOIN model AS m ON i.modelId = m.modelId -- Single line INNER JOINS since more than one JOIN
	WHERE
		s.soldDate BETWEEN DATE('2023-01-01') AND DATE('2023-12-31')
	GROUP BY
		e.employeeId
),
MostExpensiveCars AS ( -- They share the WITH keyword!
	SELECT
		e.employeeId, -- We don't need first and last name since they will be the same as in LeastExpensiveCars
		MAX(s.salesAmount) AS mostExpensive,
		m.model AS mostExpensiveModel,
		i.colour AS mostExpensiveColour
	FROM
		employee AS e
	INNER JOIN sales AS s ON e.employeeId = s.employeeId
	INNER JOIN inventory AS i ON s.inventoryId = i.inventoryId
	INNER JOIN model AS m ON i.modelId = m.modelId -- Single line INNER JOINS since more than one JOIN
	WHERE
		s.soldDate BETWEEN DATE('2023-01-01') AND DATE('2023-12-31')
	GROUP BY
		e.employeeId
)
SELECT
	l.employeeId,
	l.firstName,
	l.lastName,
	l.leastExpensive,
	l.leastExpensiveModel,
	l.leastExpensiveColour,
	m.mostExpensive,
	m.mostExpensiveModel,
	m.mostExpensiveColour
FROM
	LeastExpensiveCars AS l
INNER JOIN
	MostExpensiveCars AS m -- Joining two CTEs is crazy, this is the first time I do it
ON
	l.employeeId = m.employeeId
ORDER BY
	l.employeeId;

-- That's it!!