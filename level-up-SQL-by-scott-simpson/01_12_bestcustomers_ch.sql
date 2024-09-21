-- Identify a few customers who have ordered delivery
-- from the restaurant the most often, so we can send
-- them a promotional coupon.

-- This one is interesting!

-- I'm just gonna go with the customers who have places the most orders
SELECT
	CustomerID,
	COUNT(CustomerID) AS OrderCount
FROM
	Orders
GROUP BY
	CustomerID
ORDER BY
	OrderCount DESC

-- "Identify a few". So let's take the top 10
SELECT
	CustomerID,
	COUNT(CustomerID) AS OrderCount
FROM
	Orders
GROUP BY
	CustomerID
ORDER BY
	OrderCount DESC
LIMIT 10;

-- Let's now join this with the customer table so that we can see first name, last name and e-mail in order
-- to send them the promotional coupons
SELECT
	o.CustomerID,
	COUNT(o.CustomerID) AS OrderCount,
	c.FirstName,
	c.LastName,
	c.Email
FROM
	Orders AS o
INNER JOIN
	Customers AS c
ON
	o.CustomerID = c.CustomerID
GROUP BY
	o.CustomerID
ORDER BY
	OrderCount DESC
LIMIT 10;

-- As a final touch, let's also include their favorite dish so that we can give them a discount on it
SELECT
	o.CustomerID AS "Customer ID",
	COUNT(o.CustomerID) AS "Order Count",
	c.FirstName AS "First Name",
	c.LastName AS "Last Name",
	c.Email AS "E-mail",
	d.Name AS "Favorite Dish"
FROM
	Orders AS o
INNER JOIN
	Customers AS c
ON
	o.CustomerID = c.CustomerID
INNER JOIN
	Dishes AS d
ON
	c.FavoriteDish = d.DishID
GROUP BY
	o.CustomerID
HAVING
	"Order Count" > 13 -- Fine tuned after watching the solution in the video to include all who have ordered 14 or more!
ORDER BY
	"Order Count" DESC
-- LIMIT 13; 
	
