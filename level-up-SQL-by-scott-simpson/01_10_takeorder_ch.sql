-- Enter a customer's delivery order into our database, 
-- and provide the total cost of the items ordered.

-- Use this order information:
-- Customer: Loretta Hundey, at 6939 Elka Place
-- Items: 1 House Salad, 1 Mini Cheeseburgers, and
-- 1 Tropical Blue Smoothie
-- Delivery date and time: September 20, 2022 @ 2PM (14:00)
-- There are no taxes or other fees.

-- This is slightly overwhelming haha but let's start by getting Loretta's customer ID:
SELECT CustomerID FROM Customers WHERE FirstName = 'Loretta' AND LastName = 'Hundey'

-- Only one unique result and the customer ID is 70!

-- Now, I believe I need to insert into both the Orders table and the OrdersDishes table. Let's start with the Order table:
INSERT INTO Orders
	(CustomerID, OrderDate)
VALUES
	(70, '2022-09-20 14:00:00')
-- The order was created with Order ID 1001! We will need this now when inserting all the dishes she has ordered into the 
-- OrdersDishes table:
INSERT INTO OrdersDishes
	(OrderID, DishID)
VALUES
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'House Salad')),
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'Mini Cheeseburgers')),
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'Tropical Blue Smoothie'))
	
-- Now finally, let's get the total for the order:
SELECT
	SUM(d.Price) AS "Order total"
FROM 
	OrdersDishes AS od
INNER JOIN
	Dishes AS d
ON
	od.DishID = d.DishID
WHERE
	od.OrderID = 1001
	
	
-- Earlier solution of entering the orders into the OrderDishes table one by one:
/*
-- The House Salad:
INSERT INTO OrdersDishes
	(OrderID, DishID)
VALUES
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'House Salad'))

-- The Mini Cheeseburger:
INSERT INTO OrdersDishes
	(OrderID, DishID)
VALUES
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'Mini Cheeseburgers'))

-- The Tropical Blue Smoothie:
INSERT INTO OrdersDishes
	(OrderID, DishID)
VALUES
	(1001, (SELECT DishID FROM Dishes WHERE Name = 'Tropical Blue Smoothie'))
*/