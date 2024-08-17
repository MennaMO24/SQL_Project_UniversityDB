--1 Create a Database in SQL
--CREATE DATABASE  UniversityDB;

--2 Creating Data in SQL
CREATE TABLE students(
  student_id INT PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR,
  birth_date DATE
);

INSERT INTO
  students (student_id, first_name, last_name, birth_date)

VALUES
    (1 ,'John' ,'Doe'  ,'2000-01-15'),
    (2 ,'Jane' ,'Smith' ,'1999-03-22'),
    (3 ,'Alice'  ,'Johnson' ,'2001-07-30'),
    (4 ,'Bob','Brown','2000-12-05');



CREATE TABLE Courses(
  course_id INT PRIMARY KEY,
  course_name VARCHAR,
  course_code VARCHAR
);

INSERT INTO
  Courses (course_id, course_name, course_code)

VALUES
    (1,'Database Systems','CS101'),
    (2,'Algorithms','CS102'),
    (3,'Structures','CS103'),
    (4,'Operating Systems','CS104');

--3 Reading/Querying Data in SQL
SELECT * 
FROM students;

SELECT * 
FROM Courses;

--4 Updating/Manipulating Data in SQL
ALTER TABLE Courses
ADD Credits INT;

UPDATE Courses
SET Credits = 4
WHERE course_name = 'Algorithms';

--5 Deleting Data in SQL
DELETE FROM students
WHERE first_name = 'John' AND last_name = 'Doe';

--ADD COLUMN
ALTER TABLE students
ADD enrollment_date DATE;

UPDATE students
SET enrollment_date = '2024-01-10'
WHERE student_id = 1;

UPDATE students
SET enrollment_date = '2023-06-15'
WHERE student_id = 2;

UPDATE students
SET enrollment_date = '2023-08-20'
WHERE student_id = 3;

UPDATE students
SET enrollment_date = '2024-02-15'
WHERE student_id = 4;

--6 Filtering Data in SQL
SELECT *
FROM students
WHERE enrollment_date > '2023-09-01';


--ADD COLUMN
UPDATE Courses
SET Credits = 3
WHERE course_name = 'Database Systems';

UPDATE Courses
SET Credits = 1
WHERE course_name = 'Structures';

UPDATE Courses
SET Credits = 2
WHERE course_name = 'Operating Systems';

--7 SQL Operators
SELECT *
FROM Courses
WHERE Credits > 3;


--8 Aggregation Data in SQL
SELECT COUNT(*) AS total_students
FROM students;

SELECT AVG(Credits) AS average_credits
FROM Courses;

--9 Constraints in SQL
ALTER TABLE Courses
ADD CONSTRAINT chk_credits_non_negative CHECK (Credits >= 0);

-- ADD TABLE 
INSERT INTO students (student_id, first_name, last_name, birth_date, enrollment_date)
VALUES (1, 'Emily', 'Davis', '2002-05-10', '2024-10-24');

CREATE TABLE Enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES 
    (1, 1, 1, '2023-09-01'),
    (2, 2, 2, '2023-10-01'),
    (3, 3, 3, '2023-11-01'), 
    (4, 4, 4, '2023-12-01');

--10 Joins in SQL
SELECT s.student_id, s.first_name, s.last_name, c.course_name, e.enrollment_date
FROM Enrollments e JOIN students s 
ON e.student_id = s.student_id
JOIN Courses c 
ON e.course_id = c.course_id;


--11 SQL Functions
SELECT course_id, course_name, LENGTH(course_name) AS name_length
FROM Courses;


--12 Subqueries in SQL
SELECT s.student_id, s.first_name, s.last_name
FROM students s JOIN Enrollments e 
ON s.student_id = e.student_id
WHERE e.course_id IN (
    SELECT course_id
    FROM Courses
    WHERE Credits > 3
);


--13 Views in SQL
CREATE VIEW StudentCourseView AS
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students s
JOIN Enrollments e 
ON s.student_id = e.student_id
JOIN Courses c 
ON e.course_id = c.course_id;

SELECT * 
FROM StudentCourseView;


--14 Indexes in SQL
CREATE INDEX idx_last_name
ON students (last_name);

SELECT * 
FROM students
WHERE last_name = 'Brown';

--15 Transactions in SQL
START TRANSACTION;

-- Insert a new student
INSERT INTO students (student_id, first_name, last_name, birth_date, enrollment_date)
VALUES (5, 'Menna', 'Mohamed', '2004-10-24', '2024-02-07');

-- Insert a new course
INSERT INTO Courses (course_id, course_name, course_code)
VALUES (5, 'Python', 'CS105');

-- Commit the transaction
COMMIT;

--16 Advanced Mixed Data in SQL
CREATE TABLE MixedData (
    id SERIAL PRIMARY KEY,        
    name VARCHAR(100),             
    age INT,                       
    birth_date DATE,               
    salary NUMERIC(10, 2),         
    is_active BOOLEAN        
);

INSERT INTO MixedData (name, age, birth_date, salary, is_active)
VALUES 
    ('Alice', 30, '1994-05-15', 60000.00, TRUE),
    ('Bob', 25, '1999-08-22', 55000.50, FALSE),
    ('Charlie', 35, '1988-12-01', 70000.00, TRUE),
    ('Diana', 28, '1995-03-10', 50000.75, TRUE);

SELECT 
    id,
    name || ' is ' || age || ' years old' AS description, -- Concatenate string and integer
    EXTRACT(YEAR FROM AGE(birth_date)) AS calculated_age,  -- Calculate age from birth_date
    salary, 
    is_active
FROM MixedData
WHERE is_active = TRUE
ORDER BY salary DESC;
