--Author: Nicholas Carnival
--Date: March 18 2019 


/*--------------------------------------------------------------------------------------
 * Create the tables 
*/--------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Artist CASCADE;
CREATE TABLE Artist (
    ID serial,
    Type text,
    Name text,   
    PRIMARY KEY (ID)
);
--Label table
DROP TABLE IF EXISTS Label CASCADE;
CREATE TABLE Label (
    ID serial , 
    Location text,
    Name text,
    PRIMARY KEY (ID)
);
--Has two ID's that reference both Artist and Label
DROP TABLE IF EXISTS Album CASCADE;
CREATE TABLE Album (
    ArtistID int, 
    LabelID int,
    ID serial,
    Title text,
    Genre text,
    Year date,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ID), 
    FOREIGN KEY (LabelID) REFERENCES Label(ID), 
    PRIMARY KEY (ID)
);
DROP TABLE IF EXISTS Genre;
CREATE TABLE Genre (
    AlbumID int,
    genreType text,
    FOREIGN KEY (AlbumID) REFERENCES Album(ID)
);
--TrackInfo is a partial key
DROP TABLE IF EXISTS Track CASCADE;
CREATE TABLE Track (
        AlbumID int REFERENCES Album(ID), 
        ArtistID int REFERENCES Artist(ID),
        Name text,
        Number integer,
        PRIMARY KEY(AlbumID, ArtistID, name)
);
-- Artist is either in a group or an individual
DROP TABLE IF EXISTS membership CASCADE;
CREATE TABLE membership (
    membershipID serial,
    groupID text,
    startYear int,
    endYear int,
    PRIMARY KEY(membershipID)
); 

/*--------------------------------------------------------------------------------------
 * Insertion into tables
*/--------------------------------------------------------------------------------------

--populate the artist table first
INSERT INTO artist (name)
SELECT DISTINCT artist_name 
FROM project6
;
