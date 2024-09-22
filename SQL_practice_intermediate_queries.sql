-- SQL Practice: Intermediate Queries
-- https://www.linkedin.com/learning/sql-practice-intermediate-queries

-- #1:
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(d.Price) AS TotalSpend
FROM
    Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
INNER JOIN OrdersDishes AS od ON o.OrderID = od.OrderID
INNER JOIN Dishes AS d ON d.DishID = od.DishID
GROUP BY 
    c.CustomerID
HAVING 
    SUM(d.Price) > 450.00
ORDER BY 
    TotalSpend DESC;
	
-- #2:
-- I feel like we might need GROUP_CONCAT for this
SELECT
    o.OrderID,
    GROUP_CONCAT(d.Name ORDER BY d.Name) AS Items
FROM
    Orders AS o
INNER JOIN OrdersDishes AS od ON o.ORDERID = od.ORDERID
INNER JOIN Dishes AS d ON od.DISHID = d.DISHID
WHERE
    o.OrderDate >= '2022-05-01'
GROUP BY
    o.OrderID;
	
-- #3:
-- Works in CoderPad
SELECT
    COUNT(d.DishID) AS NumSold,
    CAST(o.OrderDate AS Date) AS Day
FROM
    Orders AS o
INNER JOIN OrdersDishes AS od ON o.ORDERID = od.ORDERID
INNER JOIN Dishes AS d ON od.DISHID = d.DISHID
WHERE 
	d.NAME = 'Handcrafted Pizza'
GROUP BY
	Day

-- Works in DB Browser
SELECT
    COUNT(d.DishID) AS NumSold,
    DATE(o.OrderDate) AS Day
FROM
    Orders AS o
INNER JOIN OrdersDishes AS od ON o.ORDERID = od.ORDERID
INNER JOIN Dishes AS d ON od.DISHID = d.DISHID
WHERE 
	d.NAME = 'Handcrafted Pizza'
GROUP BY
	Day
	
-- Double check
SELECT
	o.OrderID,
	DATE(o.OrderDate) AS Day,
	d.Name
FROM Orders AS o
INNER JOIN OrdersDishes AS od ON o.OrderID = od.OrderID
INNER JOIN Dishes AS d ON od.DishID = d.DishID

-- #4:
-- I feel this is a perfect use case to use the CASE keyword!
SELECT
	Name,
	Description,
	Type,
	CASE
		WHEN Price < 7.0 THEN 0.95
		WHEN Price BETWEEN 7 AND 10 THEN 0.90
		ELSE 0.85 -- But there is not a single item on the menu that is +$10.00?
	END AS Discount,
	Price * Discount
FROM 
	Dishes
	
SELECT * FROM Dishes ORDER BY Price DESC

-- I'm asking ChatGPT why this doesn't work and the suggestions it's giving me look awful. Let's watch the
-- solution video
-- Wow. you do need to repeat the CASE
-- Actually no, I don't think we need to if we use a CTE!
WITH DiscountCTE AS (
	SELECT
		Name,
		Description,
		Type,
		Price,
		CASE
			WHEN Price < 7.0 THEN 0.95
			WHEN Price BETWEEN 7 AND 10 THEN 0.90
			ELSE 0.85
		END AS Discount
	FROM
		Dishes
)
SELECT
	Name,
	Description,
	Type,
	ROUND(Price * Discount, 2) AS DiscountedPrice
FROM 
	DiscountCTE
	
-- I'm just now realizing that, yes, he's using two CASES in the video but he doesn't actually repeat
-- himself. He's using one to display the % discount and one for the actual calculation. Along with
-- the original price. I actually like this better
SELECT
	Name,
	Price AS "Original price",
	CASE	
		WHEN Price < 7.0 THEN '5%'
		WHEN Price BETWEEN 7 AND 10 THEN '10%'
		ELSE '15%'
	END AS "Discount percent",
	ROUND(
		Price * (
			CASE
				WHEN Price < 7.0 THEN 0.95
				WHEN Price BETWEEN 7 AND 10 THEN 0.90
				ELSE 0.85
			END)
		, 2) AS "Discounted price"
FROM
	Dishes
ORDER BY
	Name
	
-- #5:
-- Very interesting formatting challenge!
-- We don't have the Employees table in our database haha

-- This is everything I was able to do before looking at the solutions video!
SELECT
	--AS ID
	LastName || ', ' || FirstName AS Name,
	LOWER(SUBSTR(FirstName,1,1)) || LOWER(LastName) AS Login,
	Username || '@nadias-garden.com' AS Email
FROM
	Employees
ORDER BY
	Name
	
-- LPAD had to be used which I have never used :)
SELECT
	LPAD(EmployeeID, 5, 0) AS ID,
	LastName || ', ' || FirstName AS Name,
	LOWER(SUBSTR(FirstName,1,1)) || LOWER(SUBSTR(LastName,1,7)) AS Login,
	Username || '@nadias-garden.com' AS Email
FROM
	Employees
ORDER BY
	Name