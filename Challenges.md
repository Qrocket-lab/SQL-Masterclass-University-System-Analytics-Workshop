# 📝 University SQL Challenges

Use the four tables (`Students`, `Courses`, `Professors`, `Enrollment`) to solve the following problems.

---

## Tier 1: Beginner Fundamentals (SELECT, WHERE, ORDER BY)

| # | Goal | Hint |
| :--- | :--- | :--- |
| **1** | **All CS Courses:** Retrieve all information for courses offered by the 'Computer Science' department. | Filter the `Courses` table using `WHERE`. |
| **2** | **Recent Enrollees:** Find the `first_name` and `last_name` of students who enrolled in the year 2023 or later. | Filter the `Students` table. |
| **3** | **Professor History:** List all professors, ordered by their **hire_date** from oldest to newest. | Use `ORDER BY`. |
| **4** | **High Grades:** Find the **student_id** and `course_id` for all enrollments where the `grade` was 3.50 or higher. | Use a simple `SELECT` and `WHERE` on the `Enrollment` table. |
| **5** | **4-Credit Courses:** Find the names of all courses that are worth exactly 4 credits. | Filter the `Courses` table. |

---

## Tier 2: Intermediate Aggregation and Joins (GROUP BY, HAVING)

| # | Goal | Hint |
| :--- | :--- | :--- |
| **6** | **Average Course Grade:** Calculate the average `grade` for each `course_id`. | Use `AVG()` and `GROUP BY`. |
| **7** | **Student GPA:** Calculate the average `grade` (GPA) for each student, displaying their `student_id` and the calculated GPA. | Use `AVG()` and `GROUP BY student_id`. |
| **8** | **Under-enrolled Courses (HAVING):** Find the `course_id` of courses that have **fewer than 3** total enrollments. | Use `COUNT()` and `HAVING`. |
| **9** | **Professor Teaching Load:** Find the `first_name` and `last_name` of the professor who taught the most courses. | Requires a `JOIN`, `COUNT()`, `GROUP BY`, and `ORDER BY` with a `LIMIT/FETCH`. |
| **10** | **Unused Courses:** Find the names of courses that have **never** had any student enrollment. | Use a `LEFT JOIN` from `Courses` to `Enrollment` and check for `NULL` in the `Enrollment` columns. |

---

## Tier 3: Advanced Analytics (Window Functions and CTEs)

| # | Challenge | Technique |
| :--- | :--- | :--- |
| **11** | **Course Rank by Grade:** For all enrollments in a single course (e.g., 'CS101'), rank the students based on their grade (highest grade = Rank 1). | Use `RANK() OVER (PARTITION BY course_id ORDER BY grade DESC)`. |
| **12** | **Department GPA:** Retrieve every enrollment record. In addition to the enrollment details, include the **overall average grade** for that student's major on every row. | Use a **CTE** to calculate the major average first, then `JOIN` to the `Students` table. (Alternative: Use `AVG() OVER (PARTITION BY major)` if supported). |
| **13** | **Below Average Courses (CTE):** Find all courses where the course's overall average grade is lower than the **global average grade** across all courses. | Use one **CTE** to find the global average and a second **CTE** to find the average per course. Compare the two in the main query. |
| **14** | **Student's First Course:** For every student who has taken more than one course, find the `course_name` of the very first course they enrolled in (based on the earliest semester/year). | Use `ROW_NUMBER() OVER (...)` and filter for `row_num = 1` within a **CTE**. |
| **15** | **Professor Longevity Bonus:** Identify the top 50% of professors based on their years of service (oldest hire date). | Use a **CTE** to rank the professors, then use the `NTILE(2)` or `PERCENT_RANK()` Window Function to split them into groups. |
