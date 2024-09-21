-- Determine how many copies of the book 'Dracula'
-- are available for library patrons to borrow.

-- Interesting first problem! Off the top of my dome, I don't know where to start! :D

-- I guess it is the case that the same book can appear several times in the books table! Let's check:
SELECT
	*
FROM
	Books
WHERE
	Title = 'Dracula'
	
-- There are indeed three copies of this book in the library! Let's now check all books that are currently on loan:
SELECT
	*
FROM
	Loans
WHERE
	ReturnedDate IS NULL;
	
-- We should now be able to join these two subtables:
SELECT
	COUNT(*) AS "Dracula books on loan right now"
FROM
	Loans
WHERE
	ReturnedDate IS NULL AND
	BookID IN (SELECT BookID FROM Books WHERE Title = 'Dracula');

-- This returns one result! Meaning that one is on loan and *2* are available! Running the first query
-- again, we can double check that BookID 73 is indeed Dracula. Fun and healthy problem!

-- Let's go the extra mile and write from memory like he did in the video to get all in one big query:
SELECT
	(SELECT COUNT(*) FROM Books WHERE Title = 'Dracula') - 
	(SELECT
		COUNT(*)
	FROM
		Loans
	WHERE
		ReturnedDate IS NULL AND
		BookID IN (SELECT BookID FROM Books WHERE Title = 'Dracula'))
	AS "Available Dracula copies"