/*
Created by: Steven Lomon Lennartsson
Create date: 9/20/2024

VIEWS and Stored queries
Creating a view is most likely the solution if we find ourselves having the repeatedly write the same query!
Management want to see how each city is performing against the global average sales
Requirement: Generate a report every week of all albums, their associated tracks and the artist who sang them
*/

-- A view is also known as a virtual table!

CREATE VIEW V_AllAlbumsReport AS
SELECT
	al.AlbumId,
	al.Title AS "Album Title",
	t.Name AS "Track Name",
	ar.Name AS "Artist Name"
FROM
	Track AS t
INNER JOIN 
	Album AS al
ON 
	t.AlbumId = al.AlbumId
INNER JOIN
	Artist AS ar
ON
	al.ArtistId = ar.ArtistId
	