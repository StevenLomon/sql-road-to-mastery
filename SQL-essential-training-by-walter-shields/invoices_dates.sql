/*
Created by: Steven Lomon Lennartsson
Create date: 9/18/2024
Description: This query answers the question: "How many invoices were billed on May 22, 2010?"
Update to requirement: How many invoices were billed in after May 22 2010 and have a total of less than $3.00?
*/

SELECT
	InvoiceDate
	BillingAddress,
	BillingCity,
	total
FROM
	Invoice
WHERE
	--InvoiceDate = '2010-05-22 00:00:00' 
	DATE(InvoiceDate) > '2010-05-22' AND total < 3.00 -- Only process the date, don't worry about time
ORDER BY
	InvoiceDate