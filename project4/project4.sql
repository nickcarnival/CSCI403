--Author: Nicholas Carnival
--Date: Feb 11 2019 

--1. How many Slytherin students are there?
    --counts the students by existence in hogwarts_students
SELECT COUNT(*) 
FROM hogwarts_students; 
--2. What is the earliest start year of any student in our data?
    --finds the minimum, other than zero, value for start
SELECT MIN(start)
FROM hogwarts_students;

--3. How many students have some missing information?
    --ugly hardcoded answer
SELECT COUNT(*) 
FROM hogwarts_students 
WHERE start IS NULL OR finish IS NULL OR house IS NULL
OR last IS NULL OR first IS NULL;
    
--4. How many Defense Against the Dark Arts (DADA) teachers have first names the same length as their last names?
SELECT COUNT(*)
FROM hogwarts_dada 
WHERE LENGTH(last) = LENGTH(first)
;
--5. How many students are listed in each house (include the number who have no house listed as well; order by greatest number of students first)?
	--this looks horrible
SELECT house, COUNT(first) FROM hogwarts_students WHERE house is NULL 
GROUP BY house
UNION 
SELECT house, COUNT(first) FROM hogwarts_students WHERE house LIKE 'G%'
GROUP BY house
UNION
SELECT house, COUNT(first) FROM hogwarts_students WHERE house LIKE 'R%'
GROUP BY house
UNION
SELECT house, COUNT(first) FROM hogwarts_students WHERE house LIKE 'S%'
GROUP BY house
UNION
SELECT house, COUNT(first) FROM hogwarts_students WHERE house LIKE 'H%'
GROUP BY house
ORDER BY count
;
--6. Which houses have more than 20 associated student records, and how many students are in those houses?
	--this requires a join from hogwarts_students and hogwarts_houses
SELECT house, COUNT(*) count
FROM hogwarts_students
GROUP BY house
having count(*) > 20
;

--7. By house, what was the average number of years spent at Hogwarts by students for whom we know both start and end years? Order by average number of years.

SELECT house, AVG (finish - start)  FROM hogwarts_students WHERE house is NULL 
GROUP BY house
UNION 
SELECT house, AVG(finish - start) FROM hogwarts_students WHERE house LIKE 'G%'
GROUP BY house
UNION
SELECT house, AVG(finish - start ) FROM hogwarts_students WHERE house LIKE 'R%'
GROUP BY house
UNION
SELECT house, AVG(finish - start) FROM hogwarts_students WHERE house LIKE 'S%'
GROUP BY house
UNION
SELECT house, AVG (finish - start) FROM hogwarts_students WHERE house LIKE 'H%'
GROUP BY house
ORDER BY avg
;
--8. Which family names (last names) appear exactly twice in the hogwarts_students table?
SELECT last, COUNT(*) count
FROM hogwarts_students
GROUP BY last
HAVING COUNT(*) = 2
;
--Subqueries and/or complex joins
--9. What are the names, houses, and house colors of the Defense Against the Dark Arts teachers (you only need to worry about the teachers who also have student records)?
SELECT d.last, d.first, h.colors, s.house
FROM hogwarts_dada d, hogwarts_houses h, hogwarts_students s
WHERE d.last = s.last AND s.house = h.house;
--10. Who is the earliest known student, and what year did he or she start?
SELECT first, last
FROM hogwarts_students
WHERE start IN (
	SELECT MIN(start) FROM hogwarts_students)
;
--11. Which student has the shortest first name?
SELECT first, last
FROM hogwarts_students
WHERE length(first) IN (
	SELECT MIN(LENGTH(first)) FROM hogwarts_students)
;
--12. Who were the Gryffindors who would have had Dolores Umbridge as DADA teacher (assume all students take DADA, and all students are at school for the entire school year starting in Fall and ending in Spring, keeping in mind that each DADA teacher listed started in Fall and left the following Spring)?
SELECT first, last FROM hogwarts_students
WHERE finish >= (
	SELECT finish FROM hogwarts_dada WHERE first LIKE 'D%')
AND start <= (
	SELECT start FROM hogwarts_dada WHERE first LIKE 'D%')
;
--13. Which students have had other family members attend Hogwarts (assume anyone with the same last name is a family member)? Order by last name and first name.
SELECT last, first FROM hogwarts_students
WHERE last IN (
	SELECT last FROM hogwarts_students GROUP BY last HAVING COUNT(*) >=2)
ORDER BY last, first
;
--14. How many students of each house are known to have started the year that Remus Lupin was the appointed DADA teacher?
SELECT COUNT(hs.first), hs.house FROM hogwarts_students AS hs
WHERE hs.start = (
    SELECT start FROM hogwarts_dada WHERE first LIKE 'Rem%')
GROUP BY hs.house
;
--Extra credit
--15. What student started in the same year as, and has the same length first and last names as a student with initials "R. H." who was in a house with a Lion as its heraldic animal? Don't return the student R. H., just the other one.
    --all of my queries could be done better with joins...
SELECT first, last FROM hogwarts_students 
WHERE LENGTH(first) = (
SELECT LENGTH(first) FROM hogwarts_students WHERE first LIKE 'R%' AND last LIKE 'H%')
AND 
LENGTH(last) = (
SELECT LENGTH(last) FROM hogwarts_students WHERE FIRST LIKE 'R%' AND last LIKE 'H%')
AND
house LIKE 'G%'
AND
first != (SELECT first FROM hogwarts_students WHERE FIRST LIKE 'R%' AND last LIKE 'H%')
;

