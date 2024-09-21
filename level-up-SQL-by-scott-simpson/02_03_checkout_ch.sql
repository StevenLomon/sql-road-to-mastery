-- Check out two books for Jack Vaan (jvaan@wisdompets.com).
-- Book 1: The Picture of Dorian Gray, 2855934983
-- Book 2: Great Expectations, 4043822646
-- The checkout date is August 25, 2022 and the 
-- due date is September 8, 2022.

-- Let's insert into the Loans table!
-- Using a WITH clause or common table expression (CTE) to avoid getting Jack Vaan's PatronID twice:
WITH PatronInfo AS (
	SELECT PatronID
	FROM Patrons
	WHERE Email = 'jvaan@wisdompets.com'
	)
INSERT INTO Loans
	(BookID, PatronID, LoanDate, DueDate) -- We can leave out ReturnedDate and it will be NULL
VALUES
	((SELECT BookID FROM Books WHERE Barcode = 2855934983),
	 (SELECT PatronID FROM PatronInfo), '2022-08-25', '2022-09-08'),
	((SELECT BookID FROM Books WHERE Barcode = 4043822646),
	 (SELECT PatronID FROM PatronInfo), '2022-08-25', '2022-09-08');
	 
-- Success!