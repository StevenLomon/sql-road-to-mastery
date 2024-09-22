-- WINDOW FUNCTIONS
-- https://www.youtube.com/watch?v=rIcB4zMYMas

-- 1. View the table
SELECT 
	Title, 
	COUNT(Title) 
FROM 
	Books 
GROUP BY 
	Title

-- 2. Order by popularity
SELECT 
	Title, 
	COUNT(Title) AS BookCount
FROM 
	Books 
GROUP BY 
	Title
ORDER BY
	BookCount DESC
	
-- I'm going to add a 5th Dracula copy to make that the single most popular book
INSERT INTO Books (Title, Author, Published, Barcode) VALUES ('Dracula', 'Bram Stoker', 1897, 1111111111)

-- 3. Add a popularity column
-- I don't know how I would add the popularity column BECAUSE IT IS DEFINED WITH A WINDOW FUNCTION haha, 
-- that makes sense
SELECT 
	Title,  
	COUNT(Title) AS BookCount,
	ROW_NUMBER() OVER (ORDER BY BookCount DESC) AS Popularity -- ROW_NUMBER() has to be coupled with OVER()
FROM 
	Books 
GROUP BY 
	Title
	
-- OVER() is the window, ROW_NUMBER() in this case is the function
-- Window: How should the data be viewed when the function is applied?
-- In the above example, we can't use our window function since *window functions and aggregates work at 
-- different stages of query execution*. Window functions come AFTER aggregation in execution. The workaround is a CTE:
WITH BookCounts AS (
	SELECT
		Title,
		COUNT(Title) AS BookCount
	FROM
		Books
	GROUP BY
		Title
)
SELECT
	Title,
	BookCount,
	ROW_NUMBER() OVER (ORDER BY BookCount DESC) AS Popularity
FROM
	BookCounts;
	
-- 4. Try different functions
WITH BookCounts AS (
	SELECT
		Title,
		COUNT(Title) AS BookCount
	FROM
		Books
	GROUP BY
		Title
)
SELECT
	Title,
	BookCount,
	ROW_NUMBER() OVER (ORDER BY BookCount DESC) AS Popularity,
	RANK() OVER (ORDER BY BookCount DESC) AS Popularity_R,
	DENSE_RANK() OVER (ORDER BY BookCount DESC) AS Popularity_DR -- Best one to use in this case imo!
FROM
	BookCounts;
	
/*Other window functions include:
FIRST_VALUE()
NTH_VALUE()
LEAD()
LAG()
AVG()
PERCENT_RANK()
CUME_DIST()
NTILE()
PERCENTILE_CONT()
PERCENTILE_DISC()
What they all have in common is that they do some calculation for each row of our data!
*/

-- 5. Try different windows
-- I've never used PARTITION BY!
-- Let's try PARTITION BY Author
WITH BookCounts AS (
	SELECT
		Author,
		Title,
		COUNT(Title) AS BookCount
	FROM
		Books
	GROUP BY
		Title
)
SELECT
	Author,
	Title,
	BookCount,
	--RANK() OVER (PARTITION BY Author ORDER BY BookCount DESC) AS Popularity_R,
	DENSE_RANK() OVER (PARTITION BY Author ORDER BY BookCount DESC) AS Popularity_DR -- Best one to use in this case imo!
FROM
	BookCounts;
	
-- I now wanna try and create cases for each decade and partition by that

-- This will be our cases
SELECT
	CASE
		WHEN Published BETWEEN 1300 AND 1399 THEN '1300s'
		WHEN Published BETWEEN 1400 AND 1499 THEN '1400s'
		WHEN Published BETWEEN 1500 AND 1599 THEN '1500s'
		WHEN Published BETWEEN 1600 AND 1699 THEN '1600s'
		WHEN Published BETWEEN 1700 AND 1799 THEN '1700s'
		WHEN Published BETWEEN 1800 AND 1899 THEN '1800s'
		WHEN Published BETWEEN 1900 AND 1999 THEN '1900s'
	END AS Century,
	Title,
	Author,
	Published
FROM
	Books
	
-- Let's wrap it in a CTE to count every book with the century included
WITH BookCountsByCentury AS (
	SELECT
		CASE
			WHEN Published BETWEEN 1300 AND 1399 THEN '1300s'
			WHEN Published BETWEEN 1400 AND 1499 THEN '1400s'
			WHEN Published BETWEEN 1500 AND 1599 THEN '1500s'
			WHEN Published BETWEEN 1600 AND 1699 THEN '1600s'
			WHEN Published BETWEEN 1700 AND 1799 THEN '1700s'
			WHEN Published BETWEEN 1800 AND 1899 THEN '1800s'
			WHEN Published BETWEEN 1900 AND 1999 THEN '1900s'
		END AS Century,
		Title,
		Author,
		Published,
		COUNT(Title) AS BookCount
	FROM
		Books
	GROUP BY
		Century, Title
)
SELECT
	Century,
	Title,
	Author,
	Published,
	BookCount,
	DENSE_RANK() OVER (PARTITION BY Century ORDER BY BookCount DESC) AS PopularityWithinCentury
FROM
	BookCountsByCentury;
	
-- 6. To fit our library scenario: What are the top 2 most popular books within each century?
-- So here we can simple take everything we just wrote, wrap it in a subquery and filter it?
SELECT * FROM
(WITH BookCountsByCentury AS (
	SELECT
		CASE
			WHEN Published BETWEEN 1300 AND 1399 THEN '1300s'
			WHEN Published BETWEEN 1400 AND 1499 THEN '1400s'
			WHEN Published BETWEEN 1500 AND 1599 THEN '1500s'
			WHEN Published BETWEEN 1600 AND 1699 THEN '1600s'
			WHEN Published BETWEEN 1700 AND 1799 THEN '1700s'
			WHEN Published BETWEEN 1800 AND 1899 THEN '1800s'
			WHEN Published BETWEEN 1900 AND 1999 THEN '1900s'
		END AS Century,
		Title,
		Author,
		Published,
		COUNT(Title) AS BookCount
	FROM
		Books
	GROUP BY
		Century, Title
)
SELECT
	Century,
	Title,
	Author,
	Published,
	BookCount,
	DENSE_RANK() OVER (PARTITION BY Century ORDER BY BookCount DESC) AS PopularityWithinCentury
FROM
	BookCountsByCentury) AS pop 
WHERE PopularityWithinCentury <= 2;

-- What is the single most book within each century?
SELECT * FROM
(WITH BookCountsByCentury AS (
	SELECT
		CASE
			WHEN Published BETWEEN 1300 AND 1399 THEN '1300s'
			WHEN Published BETWEEN 1400 AND 1499 THEN '1400s'
			WHEN Published BETWEEN 1500 AND 1599 THEN '1500s'
			WHEN Published BETWEEN 1600 AND 1699 THEN '1600s'
			WHEN Published BETWEEN 1700 AND 1799 THEN '1700s'
			WHEN Published BETWEEN 1800 AND 1899 THEN '1800s'
			WHEN Published BETWEEN 1900 AND 1999 THEN '1900s'
		END AS Century,
		Title,
		Author,
		Published,
		COUNT(Title) AS BookCount
	FROM
		Books
	GROUP BY
		Century, Title
)
SELECT
	Century,
	Title,
	Author,
	Published,
	BookCount,
	DENSE_RANK() OVER (PARTITION BY Century ORDER BY BookCount DESC) AS PopularityWithinCentury
FROM
	BookCountsByCentury) AS pop 
WHERE PopularityWithinCentury <= 1;

-- That is bonkers haha. And that is window functions!