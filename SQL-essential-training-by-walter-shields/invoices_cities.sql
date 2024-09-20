/*
Created by: Steven Lomon Lennartsson
Create date: 9/17/2024
Description: This query answers the question: "How many customers purchased two songs at $.99 each?", i.e. 
how many rows in the Invoice table has a total of $1.98?
Update to requirement: How many invoices were billed to Brussels?
Update to requirement: How many invoices were billed to Brussels, Orlando or Paris?
Update to requirement: How many invoices were billed in cities starting with B?
Update to requirement: How many invoices were billed in cities having B anywhere in its name?
Update to requirement: How many invoices were billed in cities starting with P or D?
Update to requirement: How many invoices were billed in cities starting with P or D and have a total greater than 1.98?
*/

-- % is the WILDCARD character that can be used with LIKE operator
-- PEMDAS

SELECT 
	InvoiceDate,
	BillingAddress,
	BillingCity,
	total
FROM 
	Invoice
WHERE
	--BillingCity IN ('Brussels', 'Orlando', 'Paris')
	--BillingCity LIKE '%B%'
	(BillingCity LIKE 'P%' OR BillingCity LIKE 'D%') AND total > 1.98
ORDER BY	
	InvoiceDate