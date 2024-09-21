/*
Created by: Steven Lomon Lennartsson
Create date: 9/20/2024

DML | Inserting, Updating and Deleting data in the database
*/

-- Adding an artist to the database
INSERT INTO Artist(Name) VALUES ('Jean Dawson')

-- Updating an artist in the database. The WHERE clause is VERY IMPORTANT HERE as to not update 
-- every single row in the table!
UPDATE Artist SET NAME = 'Bob Marley' WHERE ArtistId = 276

-- Deleting an artist in the database. Once again; WHERE is important as otherwise, EVERY SINGLE 
-- RECORD will be deleted
DELETE FROM Artist WHERE ArtistId = 276
