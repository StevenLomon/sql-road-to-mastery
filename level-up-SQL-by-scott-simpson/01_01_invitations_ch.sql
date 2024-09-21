-- Generate a list of customer information.

-- Show their first name, last name, and email address.
-- Sort the list of results by last name.

SELECT
	FirstName AS "First name",
	LastName AS "Last name",
	Email AS "E-mail"
FROM
	Customers
ORDER BY
	LastName
