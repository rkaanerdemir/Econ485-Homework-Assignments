1. Project context
This SQL script (hw3.sql) continues the course registration system developed in Homework 1 and Homework 2.
All queries assume that the relational schema and sample data from HW2 have been created in the database course_reg_db.

2. How to run the script
Open the script hw3.sql in MySQL Workbench.

Make sure the database course_reg_db exists and contains the tables: Student, Course, Section, Registration, and Prerequisite with the sample data from HW2.

Execute the statement

sql
USE course_reg_db;
to select the database (or run the whole file once).

For each task, select the corresponding SELECT query block and execute only the selected part to view the result table.

Capture screenshots of the results for submission as required.

3. File contents
hw3.sql contains five main queries:

Task 1: Lists each student together with the course code, course title, section number, semester, and year of the sections they are registered in (joins Student, Registration, Section, Course).

Task 2: Lists every course and the total number of registered students across all its sections, including courses with zero registrations (LEFT JOIN + GROUP BY).

Task 3: Lists each course with its prerequisite courses and the minimum required grade (self‑join on Course via the Prerequisite table).

Task 4: For a chosen target course (currently CourseID = 2), lists students who satisfy all prerequisite grade requirements and are not already registered for that course, labelling each row as ELIGIBLE or NOT ELIGIBLE.

Task 5: Identifies students who are registered for a course without meeting its prerequisites (never took the prerequisite or obtained a grade below the required minimum).

4. Assumptions
The database name is course_reg_db and it is already created and populated using the HW2 script.

Table and column names match those used in my HW2 implementation; especially:

Student(StudentID, FirstName, LastName, ...)

Course(CourseID, CourseCode, CourseTitle, ...)

Section(SectionID, CourseID, SectionNumber, Semester, Year, ...)

Registration(RegistrationID, StudentID, SectionID, Grade, ...)

Prerequisite(PrerequisiteID, CourseID, RequiredCourseID, MinimumGrade)

Grades are stored as single characters ('A', 'B', 'C', etc.), and prerequisite minimum grades are one of these letters.

For Task 4, the target course is set to CourseID = 2; this value can be changed if the instructor uses a different ID.

5. AI usage statement
For this assignment, I used an AI assistant to:

Clarify how to set up and select the MySQL schema in MySQL Workbench.

Get guidance on structuring JOIN queries for Tasks 1–5.

Refine the final versions of the SELECT queries and generate this README explanation in English.

All final SQL queries were reviewed, adapted, and tested by me to ensure they are correct for my own database design and sample data.
