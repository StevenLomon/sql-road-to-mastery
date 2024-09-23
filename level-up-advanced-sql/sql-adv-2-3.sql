-- 3. Get a list of employees who have made more than five sales this year.

-- Seems easy enough! We need to use COUNT() and HAVING to get this with carsSold more than 5
SELECT
	e.employeeId,
	COUNT(*) AS carsSold,
	MIN(s.salesAmount) AS minSalesAmount,
	MAX(s.salesAmount) AS maxSalesAmount
FROM
	employee as e
INNER JOIN
	sales AS s
ON
	e.employeeId = s.employeeId
WHERE 
	s.soldDate BETWEEN DATE('2023-01-01') AND DATE('2023-12-31')
GROUP BY
	e.employeeId
HAVING
	COUNT(*) > 5;
	
-- If we're using a VIEW however, since the aggregation has already been made, we use WHERE to filter the VIEW!
SELECT * FROM V_employees_and_car_sales WHERE carsSold > 5 ORDER BY carsSold DESC;
-- The VIEW includes all sales, not only the ones for 2023. Let's make a new view and see the results:
SELECT * FROM V_employees_and_car_sales_2023 WHERE carsSold > 5 ORDER BY carsSold DESC;
-- Different columns but that works!