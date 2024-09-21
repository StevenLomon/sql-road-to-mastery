-- Create a reservation for a customer who may or may not
-- already be listed in our Customers table.

-- Use the following information:
-- Sam McAdams (smac@kinetecoinc.com), for 5 people
-- on August 12, 2022 at 6PM (18:00)

-- First, let's find out if the customer is in our customer table
SELECT * FROM Customers WHERE Email = 'smac@kinetecoinc.com'

-- She's not! So let's insert her
INSERT INTO Customers 
	(FirstName, LastName, Email) -- This is all the info we're given. We'd need to ask for address, birthday and everything else in retrospect!
VALUES
	('Sam', 'Adams', 'smac@kinetecoinc.com')
	
-- She's given the customer ID of 102. Now let's insert her reservation in the reservations table
INSERT INTO Reservations
	(CustomerID, Date, PartySize)
VALUES
	(102, '2022-08-12 18:00:00', 5)

-- Her phone number is only given in the video, that's just silly haha. Let's update the customer record to include it
UPDATE 
	Customers
SET
	Phone = '555-555-1232'
WHERE
	CustomerID = 102