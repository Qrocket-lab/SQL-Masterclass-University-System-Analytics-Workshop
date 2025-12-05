# 🎓 SQL Masterclass: University Course Registration Analytics

This repository hosts a hands-on workshop designed to strengthen your SQL skills using a **University Course Registration** dataset. The challenges cover foundational queries, complex joins, and advanced analytical techniques to model student enrollment, course popularity, and professor data.

## 🎯 Learning Objectives

* **Foundational Skills (Tier 1):** Practice `SELECT`, `WHERE`, and `ORDER BY` for simple data retrieval on student and course information.
* **Intermediate Skills (Tier 2):** Use `GROUP BY`, `HAVING`, and various `JOIN` types to calculate course averages, find popular subjects, and identify high-performing students.
* **Advanced Analytics (Tier 3):** Master **Window Functions** (`RANK()`, `AVG() OVER (...)`) and **Common Table Expressions (CTEs)** to determine student rankings, professor load, and courses below the department average.

## 🛠️ Getting Started

To follow along with the challenges, you must first set up the database schema and populate it with mock data. All necessary SQL code is provided in the **`database_setup.sql`** file.

### University Schema Overview

The dataset consists of four core tables:

| Table Name | Description | Key Fields |
| :--- | :--- | :--- |
| **`Students`** | Personal and enrollment details. | `student_id`, `enrollment_year` |
| **`Courses`** | Course details and associated department. | `course_id`, `department` |
| **`Professors`** | Faculty staff information. | `professor_id`, `hire_date` |
| **`Enrollment`** | Links students to courses and tracks their grade. | `enrollment_id`, `student_id` (FK), `course_id` (FK), `professor_id` (FK), `grade` |

## 📝 Challenge Walkthrough

Navigate to the **`challenges.md`** file to start the workshop. Once you've attempted the problems, you can find the verified SQL solutions in the **`solutions.sql`** file.

Good luck! 🧠
