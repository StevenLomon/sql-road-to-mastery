/*
Created by: Steven Lomon Lennartsson
Create date: 9/18/2024

JOINS
What employees are responsible for the 10 highest individual sales? List their names and the names of the customers they have helped
*/

SELECT
	i.total,
	e.EmployeeId,
	e.FirstName,
	e.LastName,
	c.CustomerId,
	c.FirstName,
	c.LastName,
	i.BillingCountry
FROM
	Invoice AS i
INNER JOIN
	Customer AS c ON i.CustomerId = c.CustomerId
INNER JOIN
	Employee as e ON c.SupportRepId = e.EmployeeId
ORDER BY
	i.total DESC
LIMIT 10