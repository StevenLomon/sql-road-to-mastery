-- Create a list of books to feature in an exhibit.

-- Make a pick list of books published from 1890-1899 
-- which are not currently checked out.

-- This is so easy? 4 star difficulty?

SELECT
	*
FROM
	Books AS b
INNER JOIN
	Loans AS l
ON
	b.BookID = l.BookID
WHERE
	1890 < b.Published < 1899 AND
	l.ReturnedDate IS 
	
-- Mid-query writing I see where the difficulty lies haha! We need to find books that are NOT in the 
-- Loans table! This calls for an INNER LEFT JOIN, doesn't it? Books will still be our left table:

SELECT
	*
FROM
	Books AS b
LEFT JOIN
	Loans AS l
ON
	b.BookID = l.BookID
WHERE
	b.Published >= 1890 AND b.Published <= 1899
ORDER BY 
	Published

-- I've gotten *something* but I can't confidently say this is what is asked for in the challenge tbh. Let's
-- just make it super clear which books we're looking for; it's the books that have never been checked out as
-- well as the books that have been checked out and also returned. These are the returned books:

SELECT
	b.Published,
	b.Title,
	b.Author,
	COUNT(DISTINCT b.BookID) AS "Book count"
FROM
	Books AS b
INNER JOIN
	Loans AS l
ON
	b.BookID = l.BookID
WHERE
	b.Published >= 1890 AND b.Published <= 1899 AND
	l.ReturnedDate IS NOT NULL
GROUP BY
	b.Title
ORDER BY 
	b.Published
	
-- Double check to see if book counts are correct. They are!
/*SELECT
	*
FROM
	Books
WHERE 
	Published >= 1890 AND Published <= 1899
ORDER BY
	Title*/
	
-- Now, back to the LEFT JOIN and combining it with the query we just wrote.
-- We're using a LEFT JOIN to get all books, even if they have no corresponding entry in the Loans
-- table (i.e., they've never been checked out)
SELECT
	b.Title,
	b.Author,
	b.Published,
	COUNT(DISTINCT b.title)
FROM
	Books AS b
LEFT JOIN
	Loans AS l
ON
	b.BookID = l.BookID
WHERE
	b.Published >= 1890 AND b.Published <= 1899 
	AND (l.BookID IS NULL OR l.ReturnedDate IS NOT NULL)
GROUP BY
	b.Title, b.Published, b.Author
ORDER BY
	b.Published;
	
-- I gave up on this one and looked at the solution in the video :)
SELECT 
	Title,
	Barcode
FROM 
	Books
WHERE
	Published BETWEEN 1890 AND 1899 -- Inclusive range
	AND (BookID NOT IN (
	SELECT BookID 
	FROM Loans 
	WHERE ReturnedDate IS NULL))
ORDER BY Title;

-- Easy and simple. I'm impressed and eager to use this as inspiration to do future problems!

