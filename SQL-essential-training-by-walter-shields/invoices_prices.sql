/*
Created by: Steven Lomon Lennartsson
Create date: 9/17/2024
Description: This query answers the question: "How many customers purchased two songs at $.99 each?", i.e. 
how many rows in the Invoice table has a total of $1.98?
Update to requirement: How many invoices exist between $1.98 and $5.00?
Update to requirement: How many invoices exist that are exactly $1.98 or $5.00?
*/

SELECT 
	InvoiceDate,
	BillingAddress,
	BillingCity,
	total
FROM 
	Invoice
WHERE
	total IN (1.98, 3.96)
ORDER BY	
	InvoiceDate
