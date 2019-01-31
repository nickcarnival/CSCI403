--Nicholas Carnival
DROP TABLE IF EXISTS books1;

    CREATE TABLE books1 (
        number integer, 
        isbn text,
        publicationdate date,
        pages integer,
        ustitle text,
        uspublicationdate date,
        uspages integer );
--This was ran for every row entry
    INSERT INTO books1 (
        (number, title, isbn,
        publicationdate, pages)
    VALUES (1, 'Harry Potter and the Philosopher''s Stone',
        '0-7475-3269-9', '1997777777-06-26', 223);


