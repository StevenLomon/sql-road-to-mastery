-- Prepare a report of the library patrons
-- who have checked out the fewest books.

-- Interesting challenge! We need to use COUNT but I'm not yet sure what we're counting haha

-- But let's stick to this; every time a record in the Loans table is created, it's because someone has checked
-- out a book. So let's count the occurance of all Patron IDs in that table and join it up with the Patrons table
-- to get their names

SELECT
	l.PatronID,
	COUNT(l.PatronID) AS CheckoutCount,
	p.FirstName,
	p.LastName,
	p.Email
FROM
	Loans as l
INNER JOIN
	Patrons as p
ON
	l.PatronID = p.PatronID
GROUP BY 
	l.PatronID
ORDER BY
	CheckoutCount
	
-- Looking at the full result, we have a natural breaking point at 15 where fittingly enough the CheckoutCount
-- tips over to 16. So let's add a HAVING CheckoutCount <= 15!

SELECT
	l.PatronID AS "Patron ID",
	COUNT(l.PatronID) AS "Checkout count",
	p.FirstName AS "First name",
	p.LastName AS "Last name",
	p.Email AS "E-mail"
FROM
	Loans as l
INNER JOIN
	Patrons as p
ON
	l.PatronID = p.PatronID
GROUP BY 
	l.PatronID
ORDER BY
	"Checkout count"
	
-- Same cutoff limit as in the video! I had the other challenge with a natural breaking point from the restaurant 
-- in mind!