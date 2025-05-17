--/*An important art gallery has recently acquired a collection
--of new artworks and is preparing to launch various exhibitions.
--To manage their inventory and events they want to design a
--database that will store and organize information about:
--Artists: including details such as their name, country of
--origin, and whether they are currently alive.
--Artworks: title, production year, artistic movement, and the
--artist who created them.
--Exhibitions: Events where the artworks are showcased, with
--details such as name and price of entry.
--*/

-- CREATE THE DB, TABLES AND POPULATE THEM

CREATE DATABASE art_gallery;

USE art_gallery;

CREATE TABLE Artists
(`Name` VARCHAR(50),
Artist_id INTEGER NOT NULL PRIMARY KEY,
Country VARCHAR(50),
IsAlive BOOLEAN);

CREATE TABLE Exhibitions
(Exhibition_id INTEGER PRIMARY KEY,
Exhibition_name VARCHAR(20),
Exhibition_price FLOAT(2) NOT NULL);

-- Change VARCHAR from 20 to 50
ALTER TABLE Exhibitions
MODIFY COLUMN Exhibition_name VARCHAR(50);

CREATE TABLE Artworks
(Artwork_id INTEGER NOT NULL UNIQUE PRIMARY KEY,
Title VARCHAR(50) NOT NULL,
Date_produced INTEGER,
Artist_id INTEGER NOT NULL,
Movement VARCHAR(50),
Exhibition_id INTEGER,
FOREIGN KEY (Artist_id) REFERENCES Artists(Artist_id),
FOREIGN KEY (Exhibition_id) REFERENCES Exhibitions(Exhibition_id)
);

INSERT INTO Artists
(`Name`,Artist_id,Country,IsAlive)
VALUES
('Pablo Picasso', 001, 'Spain', 1),
('Vincent Van Gogh', 002, 'Netherlands', 0),
('Banksy', 003, 'United Kingdom', 1),
('Yayoi Kusama', 004, 'Japan', 1),
('Jean-Michel Basquiat', 005, 'United States', 0),
('Jackson Pollock', 006, 'United States', 0),
('Andy Warhol', 007, 'United States', 0),
('Ai Weiwei', 008, 'China', 1);

-- Fix mistake in column IsAlive, Picasso row, should be 0 (false) instead of 1 (true)
UPDATE Artists ar
SET
ar.IsAlive = 0
WHERE
ar.Artist_id = 001;

INSERT INTO Exhibitions
(Exhibition_id, Exhibition_name, Exhibition_price)
VALUES
(10, 'Cubist and Abstract', 30.00),
(11, 'From Cubism to Chaos', 35.00),
(12, 'Basquiat and Beyond', 35.50),
(13, 'Warhol and Modern Pop', 38.00),
(14, 'Abstract vs. Cubism', 29.50),
(15, 'Neo-Expressionism Now', 30.00),
(16, 'Abstract Energies', 25.90),
(17, 'Post-Impressionism Vibes', 33.50);

INSERT INTO Artworks
(Artwork_id, Title, Date_produced, Artist_id, Movement, Exhibition_id)
VALUES
(100, 'Guernica', 1937, 001, 'Cubism', 10),
(101, 'Les Demoiselles dAvignon', 1907, 001, 'Cubism', 11),
(150, 'Starry Night', 1889, 002, 'Post-Impressionism', 17),
(200, 'Girl with balloon', 2002, 003, 'Street Art', 12),
(180, 'Infinity Mirror Room', 1965, 004,'Contemporary', 14),
(280, 'Untitled (Skull)', 1981, 005, 'Neo-Expressionism', 15),
(120, 'No. 5', 1948, 006, 'Abstract Expressionism', 10),
(130, 'Marilyn Diptych', 1962, 007, 'Pop Art', 13),
(220, 'Dropping a Han Dynasty Urn', 1995, 008, 'Conceptual Art', 16);


-- QUERIES
-- Delete 'Guernica' from the gallery collection
DELETE FROM Artworks
WHERE
Artwork_id = 100;

-- SELECT * FROM Artworks;

-- Show the titles of the artworks, the movement and when they were produced (order by date from older to most recent)
SELECT DISTINCT
aw.Movement, aw.Date_produced, aw.Title
FROM Artworks aw
ORDER BY Date_produced ASC;

-- Which artists are still alive?
SELECT
art.`Name`
FROM Artists art
WHERE art.IsAlive = 1;

-- What are the exhibitions that cost less than 30 pounds?
SELECT UPPER(ex.Exhibition_name)
FROM exhibitions ex
WHERE Exhibition_price < 30;

-- What are the artworks created between 1960 and 1990?(from the most recent to the older)
SELECT aw.Title
FROM artworks aw
WHERE aw.Date_produced
BETWEEN 1960 AND 1990
ORDER BY Date_produced DESC;

-- Movements that start with the letter 'a'
SELECT aw.Movement
from artworks aw
WHERE
aw.Movement
LIKE'a%';

-- Which titles belong to Cubism, Abstract Expressionism and Pop Art?(Ordered alphabetically)
SELECT aw.Title
FROM artworks aw
WHERE aw.Movement
IN('Cubism', 'Abstract Expressionism', 'Pop Art')
ORDER BY Title;

-- Artists id, artworks title and date, ordered by date in ascending order
SELECT aw.artist_id, aw.title, aw.Date_produced
FROM artworks aw
ORDER BY aw.Date_produced ASC;

-- What is the average price of an exhibition? display the column under the name average_exhibition_price
SELECT ROUND(AVG(ex.exhibition_price),2) AS average_exhibition_price
FROM exhibitions ex;

-- How many works by each artist_id does the gallery have?
SELECT COUNT(title) AS how_many_works, artist_id
FROM artworks aw
GROUP BY ARTIST_ID;

-- Shows the artist id that have more than 1 work in the gallery
-- SELECT COUNT(title) AS how_many_works, artist_id
-- FROM artworks aw
-- GROUP BY ARTIST_ID
-- HAVING how_many_works > 1;

-- Show the Exhibition id, names and the artists and artworks titles in each exhibition
SELECT aw.Exhibition_id, ex.Exhibition_name, ar.`Name`, aw.Title
FROM artworks aw
JOIN artists ar ON ar.Artist_id = aw.Artist_id
JOIN exhibitions ex ON ex.Exhibition_id = aw.Exhibition_id
ORDER BY Exhibition_id ASC;

-- Create a store function that shows the exhibitions average price
DELIMITER //
CREATE FUNCTION average_price_exhibitions()
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE avg_price FLOAT;
	SELECT ROUND(AVG(exhibition_price),2) INTO avg_price
    FROM exhibitions;

	RETURN avg_price;
END //
DELIMITER ;

SELECT average_price_exhibitions();
