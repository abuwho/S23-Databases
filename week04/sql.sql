-- Submitted by: Abu Huraira
-- Email: a.huraira@innopolis.university

-- OPTIONAL: Removing the existing tables in the template
-- DROP TABLE Customers;
-- DROP TABLE Orders;
-- DROP TABLE Shippings;

-- Create all tables
CREATE TABLE university (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  location VARCHAR(255)
);

CREATE TABLE course (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  credits INT
);

CREATE TABLE student (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  native_language VARCHAR(255)
);

CREATE TABLE university_course (
  university_id INT,
  course_id INT,
  PRIMARY KEY(university_id, course_id),
  FOREIGN KEY(university_id) REFERENCES university(id),
  FOREIGN KEY(course_id) REFERENCES course(id)
);

CREATE TABLE student_course (
  student_id INT,
  course_id INT,
  PRIMARY KEY(student_id, course_id),
  FOREIGN KEY(student_id) REFERENCES student(id),
  FOREIGN KEY(course_id) REFERENCES course(id)
);


CREATE TABLE student_university (
  student_id INT,
  university_id INT,
  PRIMARY KEY(student_id, university_id),
  FOREIGN KEY(student_id) REFERENCES student(id),
  FOREIGN KEY(university_id) REFERENCES course(id)
);


-- Populate the tables
INSERT INTO university (id, name, location)
VALUES (1, 'Innopolis  University', 'Russia'),
       (2, 'Princeton University', 'Princeton, NJ'),
       (3, 'MIT', 'Cambridge, MA');

INSERT INTO course (id, name, credits)
VALUES (1, 'Databases', 4),
       (2, 'Networks', 4),
       (3, 'System and Network Administration', 3),
       (4, 'Operating Systems', 6);

INSERT INTO student (id, name, native_language)
VALUES (1, 'Munir Makhmutov', 'Russian'),
       (2, 'Giencarlo Succi', 'Italian'),
       (3, 'Manuel Mazzara', 'Spanish'),
       (4, 'Darko Bozhinoski', 'English');


-- Implement the relationships
INSERT INTO university_course (university_id, course_id)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (2, 1),
       (2, 2),
       (2, 4),
       (3, 1),
       (3, 2),
       (3, 4);

-- Add sample student-course relationships
INSERT INTO student_course (student_id, course_id)
VALUES (1, 1),
       (1, 3),
       (2, 1),
       (2, 2),
       (3, 2),
       (3, 4),
       (4, 3),
       (4, 4);
       
-- Add sample student-university relationships
INSERT INTO student_university (student_id, university_id)
VALUES (2, 1),
       (2, 3),
       (1, 2),
       (2, 2),
       (4, 3),
       (3, 4),
       (4, 4)

ON CONFLICT(student_id, university_id) DO NOTHING;


-- a. Find the universities who are located in Russia
SELECT * FROM university WHERE location = 'Russia';

-- b. Find the countries of universities who are not located in Russia but teaches Russian natives.
SELECT DISTINCT location FROM university WHERE location <> 'Russia' AND id IN (SELECT university_id FROM student_university WHERE student_id IN (SELECT id FROM student WHERE native_language = 'Russian'));

-- c. Find student ids who studies in Innopolis University.
SELECT student_id FROM student_university WHERE university_id = 1;

-- d. Find pair of course names and universities names if course credit is more than 5.
SELECT c.name AS course_name, u.name AS university_name FROM university_course uc JOIN course c ON uc.course_id = c.id JOIN university u ON uc.university_id = u.id WHERE c.credits > 5;

-- e. Find the universities who teaches English native speakers
SELECT u.name FROM university u JOIN student_university su ON u.id = su.university_id JOIN student s ON su.student_id = s.id WHERE s.native_language = 'English';
