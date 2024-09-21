-- Create reports that will be used to make three menus.

-- Create a report with all the items sorted by price (lowest to highest).
SELECT
	Type,
	Name,
	Description,
	Price
FROM 
	Dishes
ORDER BY
	Price

-- Create a report showing appetizers and beverages. (by type; only specified in the video)
SELECT
	Type,
	Name,
	Description,
	Price
FROM 
	Dishes
WHERE
	Type IN ('Appetizer', 'Beverage')
ORDER BY
	Type
	
-- Create a report with all items except beverages. (by type; only specified in the video)
SELECT
	Type,
	Name,
	Description,
	Price
FROM 
	Dishes
WHERE
	Type != 'Beverage'
ORDER BY
	Type
