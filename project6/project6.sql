--Author: Nicholas Carnival
--Date: March 18 2019 
--Project 6


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
--create another table that cross references artist with iteself
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

--The most difficult table to work with is the artist table.
--This needs to be populated with data both from the artist_name column of project6 as well as the member_name column of project6.
--When you are done, your artist table should contain:

--    Solo artists
--    Groups
--    Group members

--What am I actually trying to do?
--Find all solo artists, groups, and group members.

--project6.artist_name is the band or artist name
INSERT INTO artist (name)
    (SELECT DISTINCT artist_name FROM project6
    UNION
    SELECT DISTINCT member_name FROM project6) 
;
--INSERT INTO artist(Type)
--    SELECT artist_type FROM project6 as p6, artist as ar  where p6.artist_name = ar.name;
--;




