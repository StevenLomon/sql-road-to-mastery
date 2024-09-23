-- 3. Get a list of all sales and all customers even if some of the data has been removed

-- This calls for a FULL JOIN. I can feel it

SELECT
	s.salesId,
	s.salesAmount,
	s.soldDate,
	c.firstName,
	c.lastName,
	c.address,
	c.city,
	c.zipcode,
	c.email
FROM
	sales AS s
FULL JOIN
	customer AS c
ON
	s.customerId = c.customerId
	
-- There are indeed some rows in the result set where data is missing, such as on row 43. I am confident in this answer!

-- Looking at the video now; wtf???
-- We do have FULL OUTER JOIN in SQLite?

-- Running SELECT sqlite_version();, I see that I'm running sqlite 3.46.0, and I did some Googling and found this:
/*
2022-06-25 - Version 3.39.0
Version 3.39.0 is regular maintenance release of SQLite. The key enhancement in this release is added support for 
RIGHT and FULL JOIN. There are other language and performance enhancements as well — see the release notes for details.
*/
-- So let's go!
