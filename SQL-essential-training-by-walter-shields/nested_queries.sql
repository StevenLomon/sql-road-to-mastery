/*
Created by: Steven Lomon Lennartsson
Create date: 9/20/2024

NESTED QUERIES
Management want to see how each city is performing against the global average sales
*/

-- Subquery to get global average sales
/*
SELECT
	ROUND(avg(total), 2) AS 'Global average sales'
FROM
	Invoice
WHERE
	BillingCity IS NOT NULL
*/
	
-- Without CROSS JOIN
/*
SELECT
	BillingCity,
	ROUND(AVG(total), 2) AS "City average sales",
	(
	SELECT
		ROUND(avg(total), 2)
	FROM
		Invoice
	WHERE
		BillingCity IS NOT NULL
	) AS "Global average sales"
FROM
	Invoice
WHERE 
	BillingCity IS NOT NULL
GROUP BY
	BillingCity
ORDER BY
	"City average sales" DESC
*/

-- Using CROSS JOIN
WITH GlobalAvg AS (
	SELECT ROUND(avg(total), 2) AS "Global average sales"
	FROM Invoice
	WHERE BillingCity IS NOT NULL
)
SELECT
	i.BillingCity,
	ROUND(AVG(i.total), 2) AS "City average sales",
	g."Global average sales" 
FROM
	Invoice AS i
CROSS JOIN
	GlobalAvg AS g
WHERE 
	BillingCity IS NOT NULL
GROUP BY
	BillingCity
ORDER BY
	"City average sales" DESC
	
-- Non-aggreate subqueries
SELECT
	InvoiceDate,
	BillingAddress,
	BillingCity
FROM
	Invoice
WHERE
	InvoiceDate >
	(
		SELECT InvoiceDate
		FROM Invoice
		WHERE InvoiceId = 251
	)

SELECT
	InvoiceDate,
	BillingAddress,
	BillingCity
FROM
	Invoice
WHERE
	InvoiceDate IN
	(
		SELECT InvoiceDate
		FROM Invoice
		WHERE InvoiceId IN (251, 252, 254)
	)
	
-- Subqueries and DISTINCT | Which tracks are not selling?
SELECT
	TrackId,
	Name,
	Composer
FROM
	Track
WHERE
	TrackId NOT IN 
	(
		SELECT DISTINCT TrackId
		FROM InvoiceLine
		ORDER BY TrackId
	)