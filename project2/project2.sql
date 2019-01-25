
/*
 *  project2.sql
 * 
 * Author: Nicholas Carnival
 *
 */

1) What animal is on the crest of the Hufflepuff house?
	Badger
	SELECT animal FROM hogwarts_houses WHERE house LIKE 'Huff%';
2) What years did Sirius Black start and finish at Hogwarts?
	start: 1971, finish: 1978
	SELECT start, finish FROM hogwarts_students WHERE first LIKE 'Sirius' ;	
3) Which student (first and last name) started at Hogwarts in 1947?
	first: Minerva, last: McGonagall
	SELECT first, last FROM hogwarts_students WHERE start = 1947;
4) What are the relics of the Hogwarts houses?
	Sword, Cup, Ring, Diadem
	SELECT relic FROM hogwarts_houses;
5) How many years was Katie Bell at Hogwarts?
	years: 7
	SELECT finish-start FROM hogwarts_students WHERE first LIKE 'Katie';
6) What students houses are unknown?
	Emma, Davey, Olive, Bertha, Sally-Anne
	SELECT first FROM hogwarts_students WHERE house IS null;	
7) What are the names of all Gyffindor students who started in 1991, given as "firstname lastname", without extra spaces, ordered by last name and fist name?E.g.,the answer should include strings like: Hermione Granger, Harry Potter, Ronald Weasley
	SELECT first, last FROM hogwarts_students WHERE start = 1991;
Susan      | Bones
Terry      | Boot
Mandy      | Brocklehurst
Lavender   | Brown
Millicent  | Bulstrode
Vincent    | Crabbe
Tracey     | Davis
Seamus     | Finnigan
Gregory    | Goyle
Hermione   | Granger
Daphne     | Greengrass
Wayne      | Hopkins
Megan      | Jones
Su         | Li
Neville    | Longbottom
Ernie      | Macmillan
Draco      | Malfoy
Morag      | McDougal
Theodore   | Nott
Pansy      | Parkinson
Padma      | Patil
Parvati    | Patil
Harry      | Potter
Zacharias  | Smith
Dean       | Thomas
Lisa       | Turpin
Ronald     | Weasley
Blaise     | Zabini
Sally-Anne | Perks

8) What defense against the dark arts teachers last name started with 'L' whose first name did not start with 'G'?
	Lupin Remus
	SELECT first, last FROM hogwarts_dada WHERE last LIKE 'L%' AND first NOT LIKE 'G%';
9) What members of the Weasley family attend Hogwarts and when did they attend. ordered by start year?
	SELECT first, last FROM hogwarts_students WHERE last LIKE 'Weas%' ORDER BY start;
10) Give the name of the Hogwarts houses, sorted by animal
	SELECT house FROM hogwarts_houses ORDER BY animal;
11) Give all information about Hufflepuff students, sorted by start year in descending order, then by last name.
		
/* Please delete the queries above and replace with your queries for       */
/* project2!                                                               */

-- Note you can also do single-line comments this way




