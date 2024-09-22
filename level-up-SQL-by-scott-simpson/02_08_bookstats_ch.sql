-- Create two reports about book statistics.

-- Report 1: Show how many titles were published 
-- in each year.

-- Report 2: Show the five books that have been
-- checked out the most.

-- I'm gonna just straight to Report 2 because it's almost the opposite of the patrons that have checked out the least.
-- I'm gonna try and do it without looking at that query:

SELECT
	b.Title,
	b.Author,
	b.Barcode,
	COUNT(l.BookID) AS "Checkout count"
FROM
	Books AS b
INNER JOIN
	Loans AS l
ON
	b.BookID = l.BookID
GROUP BY
	b.Title
ORDER BY "Checkout count" DESC
LIMIT 5;

-- First try! Now on to Report 1! Also doesn't sound too hard. Also uses COUNT and GROUP BY and I don't even think
-- we need to do any joins:

SELECT
	Published AS "Publish year",
	COUNT(Published) AS "Count"
FROM
	Books
GROUP BY
	Published
	
-- That was so incredibly easy? Did I miss something? The penultimate challenge was harder than the ultimate one

-- Just watched the beginning of the video. I think the challenge in Report 1 might lie in the fact that I have
-- the same book being counted more than once..
-- In the video he says "counting only one copy of each title we have multiples of". Why is that not clearly written
-- in the challenge brief in the text haha? We need to use DISTINCT

SELECT
	DISTINCT Title,
	Published AS "Year"
FROM
	Books
ORDER BY
	Year

-- This one has got me stuck! I take back what I wrote earlier!
-- But okay, I think I've got something. Let's use the query above as our subquery

SELECT
	Published,
	COUNT(DISTINCT Title) AS "Book count"
FROM
	Books
GROUP BY
	Published
	
-- No subquery was needed, only the pattern COUNT(DISTINCT Field) which I hadn't used so far neither in
-- Walter Shield's course nor this one haha. I asked ChatGPT to combine these two queries:
SELECT
    Published,
    COUNT(DISTINCT Title) AS "Book count",
    GROUP_CONCAT(Title, ', ') AS "Book Titles"
FROM
    (SELECT DISTINCT Title, Published FROM Books) AS DistinctBooks -- Using a subquery in the FROM clause is called a derived table!
GROUP BY
    Published
ORDER BY
    "Book count" DESC;
	
-- These are two completely new concepts; derived tables and GROUP_CONCAT. They will need some time to marinade haha

-- The solution from the video without GROUP_CONCAT (altho mentioned and removed again since not all SQL dialects
-- have that keyword
SELECT Published, COUNT(DISTINCT(Title)) AS PubCount
FROM Books
GROUP BY Published
ORDER BY PubCount DESC;
