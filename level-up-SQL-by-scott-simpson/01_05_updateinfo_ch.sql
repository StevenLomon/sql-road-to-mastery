-- Update a customer's contact information.

-- Taylor Jenkins, of 27170 6th Ave., Washington, DC,
-- has moved to 74 Pine St., New York, NY.

-- Get his customer ID
SELECT CustomerID FROM Customers WHERE Address = '27170 6th Ave.'

-- His CustomerID is 26

-- Now, update the record
UPDATE 
	Customers
SET
	Address = '74 Pine St.', 
	City = 'New York',
	State = 'NY'
WHERE
	CustomerID = 26;