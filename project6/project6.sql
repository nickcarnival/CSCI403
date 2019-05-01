-- Nicholas Carnival 
-- Date: March 18 2019
-- Project 6 

/*--------------------------------------------------------------------------------
 * Create the tables 
*/--------------------------------------------------------------------------------

DROP TABLE IF EXISTS Artist CASCADE;
CREATE Table Artist (
	ID serial,
	Name text,
	Type text,
	PRIMARY KEY(ID)
);


DROP TABLE IF EXISTS Label CASCADE;
CREATE Table Label (
	ID SERIAL,
	Location TEXT,
	Name TEXT,
	PRIMARY KEY (ID)
);	

DROP TABLE IF EXISTS Album CASCADE;
CREATE Table Album (
	ID SERIAL,
	Label_ID SERIAL NOT NULL,
	artistID SERIAL NOT NULL,
	Title TEXT,
	Year numeric(4,0),
	PRIMARY KEY (ID),
	FOREIGN KEY (artistID) REFERENCES Artist(ID),
	FOREIGN KEY (Label_ID) REFERENCES Label(ID)
);

DROP TABLE IF EXISTS genre CASCADE;
CREATE Table genre (
	albumID SERIAL NOT NULL,
	ID SERIAL NOT NULL,
	Genre TEXT,
	PRIMARY KEY(ID, Genre),
	FOREIGN KEY (albumID) REFERENCES Album(ID)
);

DROP TABLE IF EXISTS Track CASCADE;
CREATE Table Track (
	albumID SERIAL NOT NULL,
	Name TEXT NOT NULL,
	Number TEXT NOT NULL,
	PRIMARY KEY(Name, Number, albumID),
	FOREIGN KEY (albumID) REFERENCES Album(ID)
);

-- The cross table for individuals and groups
DROP TABLE IF EXISTS membership CASCADE;
CREATE Table membership(
	artistID SERIAL NOT NULL,
	memberID SERIAL NOT NULL,
	FOREIGN KEY (artistID) REFERENCES Artist(ID),
	FOREIGN KEY (memberID) REFERENCES Artist(ID),
	beginYear numeric(4,0),
	endYear numeric(4,0),
	PRIMARY KEY(artistID, memberID)
);

/*------------------------------------------------------------------------------
 * Insertion into tables
*/------------------------------------------------------------------------------

--Artist table insertions
INSERT INTO Artist (name, type)
    SELECT DISTINCT artist_name, artist_type FROM public.project6;
INSERT INTO Artist (name, type)
    SELECT DISTINCT member_name, 'Person' FROM public.project6;

--membership table insertions
INSERT INTO membership(artistID, memberID, beginYear, endYear)     
    SELECT DISTINCT a1.id, a2.id, p.member_begin_year, p.member_end_year  
    FROM artist AS a1, artist AS a2, public.project6 AS p                    
    WHERE a1.name = p.artist_name AND a2.name = p.member_name;

--label table insertions
INSERT INTO Label (name, location)
    SELECT DISTINCT label, headquarters FROM public.project6;

--album table insertions
INSERT INTO Album (title, year, artistID, label_id)
    SELECT DISTINCT p.album_title, p.album_year, artist.id, label.id
    FROM public.project6 AS p, artist, label
    WHERE p.artist_name = artist.name AND p.label = label.name;

--genre table insertions
INSERT INTO genre (albumID, genre)
    SELECT DISTINCT album.id, p.genre FROM public.project6 AS p, album
    WHERE p.album_title = album.title;

INSERT INTO Track (albumID, name, number)
    SELECT DISTINCT album.id, p.track_name, p.track_number
    FROM album, public.project6 AS p
    WHERE p.album_title = album.title;
\! echo


-- Question 1:
\! echo "Question 1: "
SELECT a1.name, beginYear, endYear 
FROM artist as a1, artist as a2, membership 
WHERE a1.id = memberID AND a2.id = artistID AND a2.name = 'The Who'
ORDER BY beginYear, a1.name;

-- Question 2:
\! echo "Question 2: "
SELECT DISTINCT a1.name 
FROM artist as a1, artist as a2, membership 
WHERE a1.id = artistID AND a2.id = memberID AND a2.name = 'Chris Thile';

-- Question 3:
\! echo "Question 3: "
SELECT title, year, label.name 
FROM artist, album, label 
WHERE album.artistID = artist.id AND artist.name = 'Talking Heads'  
AND album.label_id = label.id 
ORDER BY year;

-- Question 4:
\! echo "Question 4: "
SELECT title, year, artist, label FROM (
    SELECT DISTINCT album.title AS title, album.year AS year, a1.name 
        AS artist, label.name AS label 
        FROM artist AS a1, artist AS a2, membership, label, album 
        WHERE a1.id = membership.artistID
        AND a2.id = membership.memberID
        AND a2.name = 'Chris Thile' 
        AND album.artistID= a1.id AND album.label_id = label.id
    UNION
    SELECT album.title AS album, album.year AS year, artist.name 
        AS artist, label.name AS label 
        FROM album, artist, label 
        WHERE album.artistID = artist.id AND album.label_id = label.id 
        AND artist.name = 'Chris Thile'
    )
RESULTS
ORDER BY year;

-- Question 5:
\! echo "Question 5: "
SELECT artist.name, album.title, album.year 
FROM artist, album, genre 
WHERE genre.genre = 'electronica' AND album.artistID = artist.id 
AND genre.albumID = album.id 
ORDER BY year;

-- Question 6:
\! echo "Question 6: "
SELECT track.name, track.number 
FROM artist, album, track 
WHERE artist.name = 'Led Zeppelin' AND album.artistID = artist.id 
AND album.title = 'Houses of the Holy' AND track.albumID = album.id 
ORDER BY track.number;

-- Question 7:
\! echo "Question 7: "
SELECT DISTINCT genre.genre 
FROM genre, album, artist 
WHERE genre.albumID = album.id AND album.artistID = artist.id 
AND artist.name = 'James Taylor';

-- Question 8:
\! echo "Question 8: "
SELECT artist.name, album.title, album.year, label.name 
FROM artist, album, label 
WHERE album.label_id = label.id AND album.artistID = artist.id 
AND label.location = 'Hollywood';

