-- Register a customer for our Anniversary event.

-- The customer 'atapley2j@kinetecoinc.com' will be in
-- attendance, and will bring 3 friends.

-- Find customer ID of customer with e-mail 'atapley2j@kinetecoinc.com'
SELECT CustomerID FROM Customers WHERE Email = 'atapley2j@kinetecoinc.com'

-- The customer ID is 92. Let's insert it into the AnniversaryResponses table. "will bring 3 friends" meaning the
-- total party size is 4

INSERT INTO AnniversaryResponses
	(CustomerID, PartySize)
VALUES
	(92, 4)
	
-- We can also improve this by making it more compact and write it as one query using a subquery!

INSERT INTO AnniversaryResponses
	(CustomerID, PartySize)
VALUES (
	(SELECT CustomerID 
	 FROM Customers 
	 WHERE Email = 'atapley2j@kinetecoinc.com'), 
	 4);