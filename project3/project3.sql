/* Nicholas Carnival
*  Due: 02/01/2019
*  Part 1
*/ books1 creation
DROP TABLE IF EXISTS books1;

    CREATE TABLE books1 (
        number integer, 
        isbn text,
        publicationdate date,
        pages integer,
--Part 2 
--This was ran for every row entry
    INSERT INTO books1 (
        (number, title, isbn,
        publicationdate, pages)
    VALUES (1, 'Harry Potter and the Philosopher''s Stone',
        '0-7475-3269-9', '1997-06-26', 223);
--Part 3 (1)
--Deleted The Bunnies :(
    DELETE FROM books1
        WHERE number=8;
--Part 3 (2)
--Other more safe option
    DELETE FROM books1
        WHERE title 
        LIKE 'Harry Potter and the Bunn%';
--Part 5
--created table as select w/ all the data
    SELECT * INTO books2 
    FROM project3_us_books;
--Part 6
--final table creation
    CREATE TABLE books (
        number integer,
        title text,
        isbn text,
        publicationdate date,
        pages integer,
        ustitle text,
        uspublicationdate date,
        uspages integer);
--Part 7
--insertion into the final table using previous two tables
    INSERT INTO books
    (number, title, isbn, publicationdate, pages, uspublicationdate, uspages)
    SELECT b1.number, title, isbn, b1.publicationdate, b1.pages, books2.publicationdate, books2.pages
    FROM books1 b1
    INNER JOIN books2 ON b1.number = books2.number;
--Part 8
--updating the ustitle column
    UPDATE books
    SET ustitle=b1.title
    FROM books1 b1
    WHERE books.number = b1.number;
--Part 9
--updated Sorceres Stone
    UPDATE books
    SET ustitle='Harry Potter and the Sorcerer''s Stone'
    WHERE number=1;
    

