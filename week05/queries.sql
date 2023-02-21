-- 1. Find the names of courses in Computer science department which have 3 credits.
SELECT title FROM course WHERE credits = 3 AND dept_name = 'Comp. Sci.';


-- 2. For the student with ID 12345 (or any other value), show all course_id and title of 
-- all courses registered for by the student.
SELECT c.course_id, c.title
FROM student as s, course as c
WHERE s.id = '12345' AND c.dept_name=s.dept_name;


-- 3. Modify 2 to show the total number of credits for such courses (taken by that student). Don't display
-- the tot_creds value from the student table, you should use SQL aggregation on courses taken by the student
SELECT course.course_id, course.title, course.credits
FROM course
INNER JOIN takes ON course.course_id = takes.course_id
WHERE takes.ID = '12345'
AND course.dept_name = 'Comp. Sci.'
UNION
SELECT course.course_id, course.title, course.credits
FROM course
INNER JOIN takes ON course.course_id = takes.course_id
INNER JOIN prereq ON prereq.prereq_id = course.course_id
WHERE takes.ID = '12345'
AND prereq.course_id IN (
  SELECT course_id
  FROM takes
  WHERE ID = '12345'
)
AND course.dept_name = 'Comp. Sci.'
GROUP BY course.course_id, course.title, course.credits


-- 4. Modify 3 to display the total credits for each of the students, along with the ID of the student; don't
-- bother about the name of the student. (Don't bother about students who have not registered for any
-- course, they can be omitted)
SELECT takes.ID, SUM(course.credits) AS total_credits
FROM takes JOIN course ON takes.course_id = course.course_id
GROUP BY takes.ID;


-- 5. Find the names of all students who have taken any Comp. Sci. course ever (there should be no duplicate names)
SELECT DISTINCT student.name
FROM student
JOIN takes ON student.ID = takes.ID
JOIN course ON takes.course_id = course.course_id
WHERE course.dept_name = 'Comp. Sci.';


-- 6. Display the IDs of all instructors who have never taught a course.
SELECT ID
FROM instructor
WHERE ID NOT IN (
    SELECT DISTINCT id
    FROM teaches
)

-- 7. Modify 6 to display the names of the instructors also, not just the IDs.
SELECT instructor.id, instructor.name
FROM instructor
LEFT OUTER JOIN teaches ON instructor.id = teaches.id
WHERE teaches.id IS NULL;