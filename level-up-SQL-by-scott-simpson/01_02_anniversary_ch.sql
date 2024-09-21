-- Create a table in the database to store customer
-- responses to our anniversary invitation.

-- Associate a customer's ID number with the number of people
-- they plan to bring in their party.

-- Hint: SQLite offers the INTEGER and REAL datatypes

-- DROP TABLE "Responses"

CREATE TABLE "AnniversaryResponses" (
	-- "ResponseID" INTEGER,
	"CustomerID" INTEGER,
	"PartySize" INTEGER,
	PRIMARY KEY("CustomerID")
)