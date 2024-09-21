-- Remove incorrect information from the database.

-- A customer named Norby has notified us he won't 
-- be able to keep his Friday reservation. 
-- Today is July 24, 2022.

-- Find the specific reservation; in the future from 2022-07-24 and reserved in the name of Norby, which we'll 
-- achieve with an Inner Join
SELECT
	*
FROM
	Reservations AS r
INNER JOIN
	Customers AS c
ON
	r.CustomerID = c.CustomerID
WHERE
	r.Date > DATE('2022-07-24') AND c.FirstName = 'Norby';
	
-- To confirm that this is a Friday, some Googling reveals that July 24, 2022 was a Sunday meaning that July 29, 
-- 2022 indeed was a Friday

-- Now, remove the reservation
DELETE FROM
	Reservations
WHERE
	ReservationID = 2000;
	
-- Or, like mentioned in the video, UPDATE the record to set Date to NULL or similar to keep consistency. All
-- depends on the business logic!