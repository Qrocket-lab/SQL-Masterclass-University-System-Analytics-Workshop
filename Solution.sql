-- SQL Masterclass: University Course Registration - Verified Solutions

-----------------------------------------------------
-- TIER 1: BEGINNER FUNDAMENTALS
-----------------------------------------------------

-- #Task 1: All CS Courses
SELECT * FROM Courses 
WHERE department = 'Computer Science';

-- #Task 2: Recent Enrollees (2023 or later)
SELECT first_name, last_name 
FROM Students 
WHERE enrollment_year >= 2023;

-- #Task 3: Professor History (Oldest to Newest)
SELECT * FROM Professors 
ORDER BY hire_date ASC;

-- #Task 4: High Grades (3.50 or higher)
SELECT student_id, course_id 
FROM Enrollment 
WHERE grade >= 3.50;

-- #Task 5: 4-Credit Courses
SELECT course_name 
FROM Courses 
WHERE credits = 4;

-----------------------------------------------------
-- TIER 2: INTERMEDIATE AGGREGATION AND JOINS
-----------------------------------------------------

-- #Task 6: Average Course Grade
SELECT course_id, AVG(grade) AS average_grade 
FROM Enrollment 
GROUP BY course_id;

-- #Task 7: Student GPA
SELECT student_id, AVG(grade) AS student_gpa 
FROM Enrollment 
GROUP BY student_id;

-- #Task 8: Under-enrolled Courses (HAVING Count < 3)
SELECT course_id 
FROM Enrollment 
GROUP BY course_id 
HAVING COUNT(student_id) < 3;

-- #Task 9: Professor Teaching Load (Professor who taught the most)
SELECT 
    T1.first_name, 
    T1.last_name, 
    COUNT(T2.enrollment_id) AS total_sections_taught
FROM Professors AS T1 
JOIN Enrollment AS T2 ON T1.professor_id = T2.professor_id 
GROUP BY T1.professor_id, T1.first_name, T1.last_name
ORDER BY total_sections_taught DESC
LIMIT 1;

-- #Task 10: Unused Courses (LEFT JOIN / NULL Check)
SELECT T1.course_name 
FROM Courses AS T1 
LEFT JOIN Enrollment AS T2 ON T1.course_id = T2.course_id 
WHERE T2.enrollment_id IS NULL; -- Check for courses that have no matching enrollment record

-----------------------------------------------------
-- TIER 3: ADVANCED ANALYTICS (WINDOW FUNCTIONS & CTEs)
-----------------------------------------------------

-- #Challenge 11: Course Rank by Grade
SELECT 
    T1.first_name,
    T1.last_name,
    T2.course_id,
    T2.grade,
    RANK() OVER (PARTITION BY T2.course_id ORDER BY T2.grade DESC) AS course_grade_rank -- Ranks students within each course
FROM Students AS T1 
JOIN Enrollment AS T2 ON T1.student_id = T2.student_id 
ORDER BY T2.course_id, course_grade_rank;

-- #Challenge 12: Department GPA (Using AVG() Window Function alternative)
-- NOTE: For many SQL versions, this simpler Window Function is used instead of a complex CTE.
SELECT 
    T1.first_name,
    T1.major,
    T2.course_id,
    T2.grade,
    AVG(T2.grade) OVER (PARTITION BY T1.major) AS major_avg_gpa -- Calculates avg GPA per major across all students
FROM Students AS T1 
JOIN Enrollment AS T2 ON T1.student_id = T2.student_id 
ORDER BY T1.major, T1.first_name;

-- #Challenge 13: Below Average Courses (Chained CTEs)
WITH CourseAverages AS (
    -- Stage 1: Calculate the average grade for each course
    SELECT course_id, AVG(grade) AS avg_course_grade 
    FROM Enrollment 
    GROUP BY course_id
), 
GlobalAverage AS (
    -- Stage 2: Calculate the overall average grade across all courses/enrollments
    SELECT AVG(grade) AS global_avg_grade 
    FROM Enrollment
)
-- Final Query: Select courses where the course avg is less than the global avg
SELECT 
    T1.course_name, 
    T2.avg_course_grade
FROM Courses AS T1
JOIN CourseAverages AS T2 ON T1.course_id = T2.course_id
WHERE T2.avg_course_grade < (SELECT global_avg_grade FROM GlobalAverage)
ORDER BY T2.avg_course_grade DESC;

-- #Challenge 14: Student's First Course (ROW_NUMBER in CTE)
WITH RankedEnrollment AS (
    -- Stage 1: Assign a sequence number to each course taken by a student
    SELECT 
        student_id, 
        course_id, 
        semester, 
        ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY year ASC, semester ASC) AS rn -- Sequence by earliest date
    FROM Enrollment 
)
-- Final Query: Filter for the first course (rn=1) and join to get the name
SELECT 
    T1.first_name, 
    T2.course_name,
    T3.semester
FROM Students AS T1
JOIN RankedEnrollment AS T3 ON T1.student_id = T3.student_id
JOIN Courses AS T2 ON T3.course_id = T2.course_id
WHERE T3.rn = 1 
ORDER BY T1.first_name;

-- #Challenge 15: Professor Longevity Bonus (NTILE)
WITH ProfessorTenure AS (
    -- Stage 1: Calculate the professor ranking based on hire date
    SELECT 
        professor_id,
        hire_date,
        NTILE(2) OVER (ORDER BY hire_date ASC) as tenure_quartile -- Quartile 1 = longest service (earliest hire_date)
    FROM Professors
)
-- Final Query: Select professors in the top 50% (NTILE 1)
SELECT 
    T1.first_name, 
    T1.last_name, 
    T2.hire_date 
FROM Professors AS T1 
JOIN ProfessorTenure AS T2 ON T1.professor_id = T2.professor_id 
WHERE T2.tenure_quartile = 1 
ORDER BY T2.hire_date ASC;
