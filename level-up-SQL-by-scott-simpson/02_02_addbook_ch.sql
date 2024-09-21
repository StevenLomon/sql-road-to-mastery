-- Add books to the library database.

-- Title: Dracula
-- Author: Bram Stoker
-- Published: 1897
-- ID Number: 4819277482

-- Title: Gulliver’s Travels into Several Remote Nations of the World
-- Author: Jonathan Swift
-- Published: 1729
-- ID Number: 4899254401

-- Easy enough? Let's insert them all in one statement like I didn't intuitively do first when inserting the
-- orders into OrderDishes for the restaurant. Checking in the 'Database Structures' tab so that we are inserting
-- with the correct data types. Seems like Barcode should be a TEXT type, doesn't it?

INSERT INTO Books
	(Title, Author, Published, Barcode)
VALUES
	('Dracula', 'Bram Stoker', 1897, 4819277482),
	('Gulliver’s Travels into Several Remote Nations of the World', 'Jonathan Swift', 1729, 4899254401)
	
-- Success!
-- Except kinda not haha... looking at the video and also now looking in the books table, the name has a "proper"
-- single quote apostrophe, not a "fake" one like in the brief of the problem! So let's update it to be like he
-- showed in the video with two consecutive single quote apostrophes in order to have the SQL engine interpret this
-- as an actual single quote apostrophe. This was new to me!

UPDATE Books SET Title = 'Gulliver''s Travels into Several Remote Nations of the World' WHERE BookID = 202;

-- The updated INSERT query:
INSERT INTO Books
	(Title, Author, Published, Barcode)
VALUES
	('Dracula', 'Bram Stoker', 1897, 4819277482),
	('Gulliver''s Travels into Several Remote Nations of the World', 'Jonathan Swift', 1729, 4899254401)