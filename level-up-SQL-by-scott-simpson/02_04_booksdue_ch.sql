-- Prepare a report of books due to be returned
-- to the library on July 13, 2022.
-- Provide the due date, the book title, and
-- the borrower's first name and email address.

-- This will require some joins! And the order will be important
-- Since the Loans table have both foreign keys, I will use that as the middle table

SELECT
	l.DueDate,
	b.Title,
	p.FirstName,
	p.LastName,
	p.Email
FROM
	Books AS b
INNER JOIN
	Loans AS l
ON
	b.BookID = l.BookID
INNER JOIN
	Patrons AS p
ON 	l.PatronID = p.PatronID
WHERE
	l.DueDate = '2022-07-13' AND
	l.ReturnedDate IS NULL -- Added retroactively after watching the video. Doesn't actually change the result but
	-- it makes sense to also filter to those that haven't actually returned the book already
	
-- Success!
	