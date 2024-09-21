-- Find the reservation information for a customer whose
-- name we aren't quite sure how to spell.

-- Variations of the name include:
-- Stevensen, Stephensen, Stevenson, Stephenson, Stuyvesant

-- There are four people in the party. Today is June 14th.

SELECT
	*
FROM
	Reservations AS r
INNER JOIN
	Customers AS c
ON 
	r.CustomerID = c.CustomerID
WHERE
	r.Date > DATE('2022-06-14') AND
	r.PartySize = 4 AND
	c.LastName LIKE 'St%' -- alternatively IN ('Stevensen', 'Stephensen', 'Stevenson', 'Stephenson', 'Stuyvesant')
	
-- Only one result is given meaning we have found the one reservation we looked for! The last name was Stephenson
