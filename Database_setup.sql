-- SQL Masterclass: University Course Registration - Database Setup

-- This file contains the complete SQL code to create the necessary tables
-- and populate them with mock data for the challenges.

-----------------------------------------------------
-- 1. SCHEMA CREATION
-----------------------------------------------------

-- 1. Students Table
CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    major VARCHAR(50),
    enrollment_year INTEGER
);

-- 2. Courses Table
CREATE TABLE Courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50),
    credits INTEGER
);

-- 3. Professors Table
CREATE TABLE Professors (
    professor_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE
);

-- 4. Enrollment Table (Links Students, Courses, and Professors)
CREATE TABLE Enrollment (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER REFERENCES Students(student_id),
    course_id VARCHAR(10) REFERENCES Courses(course_id),
    professor_id INTEGER REFERENCES Professors(professor_id),
    semester VARCHAR(20),
    year INTEGER,
    grade DECIMAL(3, 2) -- Grade on a 4.0 scale
);

-----------------------------------------------------
-- 2. MOCK DATA INSERTION
-----------------------------------------------------

-- Mock Data for Students
INSERT INTO Students (student_id, first_name, last_name, major, enrollment_year) VALUES
(501, 'Alex', 'Chen', 'Computer Science', 2022),
(502, 'Bella', 'Garcia', 'Physics', 2021),
(503, 'Chris', 'Miller', 'History', 2022),
(504, 'Dana', 'Wong', 'Computer Science', 2023),
(505, 'Ethan', 'Davis', 'Physics', 2021);

-- Mock Data for Courses
INSERT INTO Courses (course_id, course_name, department, credits) VALUES
('CS101', 'Intro to Programming', 'Computer Science', 3),
('PHY201', 'Classical Mechanics', 'Physics', 4),
('HIS305', 'Modern European History', 'History', 3),
('CS350', 'Database Systems', 'Computer Science', 4),
('MAT101', 'Calculus I', 'Mathematics', 4);

-- Mock Data for Professors
INSERT INTO Professors (professor_id, first_name, last_name, department, hire_date) VALUES
(10, 'Dr. Sarah', 'Lee', 'Computer Science', '2015-08-15'),
(20, 'Dr. Mark', 'Zimm', 'Physics', '2010-01-20'),
(30, 'Dr. Emily', 'Hart', 'History', '2018-05-01');

-- Mock Data for Enrollment
INSERT INTO Enrollment (enrollment_id, student_id, course_id, professor_id, semester, year, grade) VALUES
(10001, 501, 'CS101', 10, 'Fall', 2022, 3.50), -- Alex
(10002, 502, 'PHY201', 20, 'Fall', 2021, 3.80), -- Bella
(10003, 503, 'HIS305', 30, 'Spring', 2023, 3.20), -- Chris
(10004, 501, 'CS350', 10, 'Spring', 2023, 3.90), -- Alex
(10005, 504, 'CS101', 10, 'Fall', 2023, 2.90), -- Dana
(10006, 502, 'MAT101', 20, 'Spring', 2022, 3.00), -- Bella
(10007, 505, 'PHY201', 20, 'Fall', 2021, 3.70), -- Ethan
(10008, 501, 'MAT101', 30, 'Fall', 2023, 2.50), -- Alex
(10009, 502, 'CS101', 10, 'Spring', 2022, 3.10), -- Bella
(10010, 505, 'CS350', 10, 'Spring', 2024, 3.40); -- Ethan
