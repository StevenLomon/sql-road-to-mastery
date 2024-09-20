/*
Created by: Steven Lomon Lennartsson
Create date: 9/20/2024

GROUPING
Management want us to list the average amount customers spend by billing city
Update: What are the average invoice totals by city for only the citires that start with L?
Update: Get all average totals that are greater than $5.50
Update: The above but also for cities starting with B
Update: What are the average invoices totals by billing country and city?
*/

SELECT
	BillingCountry,
	BillingCity,
	ROUND(AVG(total), 2) AS Average
FROM 
	Invoice
WHERE -- Always comes after FROM and before GROUP BY
	BillingCountry IS NOT NULL AND
	BillingCity IS NOT NULL
	--BillingCity LIKE 'B%'
GROUP BY
	BillingCountry,
	BillingCity -- Group by the non-aggregated field!
--HAVING -- Always comes after the GROUP BY clause. For filtering aggregates!
--	Average > 5.50
ORDER BY
	BillingCountry
	--Average DESC