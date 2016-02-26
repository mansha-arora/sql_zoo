-- 1. Names for teachers with NULL for their department

SELECT name
FROM teacher
WHERE dept IS NULL;

-- 2. List of teacher and department names, missing teachers with no department
--    and departments with no teachers

SELECT teacher.name, dept.name
FROM teacher JOIN dept ON (teacher.dept = dept.id);

-- 3. List of teacher and department names, missing departments with no
--    teachers

SELECT teacher.name, dept.name
FROM teacher LEFT OUTER JOIN dept
  ON (teacher.dept = dept.id);

-- 4. List of teacher and department names, missing teachers with no department

SELECT teacher.name, dept.name
FROM teacher RIGHT OUTER JOIN dept
  ON (teacher.dept = dept.id);

-- 5. Teacher names and mobile numbers, using 07986 444 2266 if there is no
--    number given

SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher;

-- 6. Teacher name and department name, using None if there is no department
--    given

SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT OUTER JOIN dept
  ON (teacher.dept = dept.id);

-- 7. Number of teachers and number of mobile phones

SELECT COUNT(name), COUNT(mobile)
FROM teacher;

-- 8. Department name and number of teachers for each department

SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT OUTER JOIN dept
  ON (teacher.dept = dept.id)
GROUP BY dept.name;

-- 9. Name for each teacher, followed by Sci if that teacher is in department 1
--    or 2, and Art otherwise

SELECT name,
  CASE
    WHEN dept IN (1, 2) THEN 'Sci'
    ELSE 'Art'
  END general_field
FROM teacher;

-- 10. Name for each teacher, followed by Sci if that teacher is in department 
--     1 or 2, Art if that teacher is in department 3, and None otherwise

SELECT name,
  CASE
    WHEN dept IN (1, 2) THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
    ELSE 'None'
  END general_field
FROM teacher;