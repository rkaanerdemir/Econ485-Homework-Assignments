-- Find all prerequisites of a course
--These queries do not block registrations directly; they provide information to the application, which decides ALLOW or BLOCK.

--Input: CourseID (for example, 2 for CS102).

-- Q1: List all prerequisites of a given course
-- Example: WHERE p.CourseID = 2;
SELECT
    c.CourseCode                AS TargetCourseCode,
    c.CourseTitle               AS TargetCourseTitle,
    rc.CourseCode               AS PrerequisiteCourseCode,
    rc.CourseTitle              AS PrerequisiteCourseTitle,
    p.MinimumGrade
FROM Prerequisite AS p
JOIN Course AS c
      ON p.CourseID = c.CourseID
JOIN Course AS rc
      ON p.RequiredCourseID = rc.CourseID
WHERE p.CourseID = 2;

--The application uses this to see which courses and minimum grades are required before the target course.

--Check whether a student passed each prerequisite
--Input: StudentID and CourseID.
--For every prerequisite of the target course, this query returns the prerequisite course, the student’s grade, and whether it satisfies the minimum grade.

-- Q2: For each prerequisite of the target course, show the student's grade
-- and whether it is acceptable.
-- Example: StudentID = 1, CourseID = 2
SELECT
    rc.CourseCode                        AS PrerequisiteCourseCode,
    rc.CourseTitle                       AS PrerequisiteCourseTitle,
    p.MinimumGrade,
    r.Grade                              AS StudentGrade,
    CASE
        WHEN r.Grade IS NULL THEN 'NO'   -- no grade = has not passed
        WHEN r.Grade IN ('A','B','C')
             AND p.MinimumGrade = 'C' THEN 'YES'
        WHEN r.Grade IN ('A','B')
             AND p.MinimumGrade = 'B' THEN 'YES'
        WHEN r.Grade = 'A'
             AND p.MinimumGrade = 'A' THEN 'YES'
        ELSE 'NO'
    END AS IsGradeAcceptable
FROM Prerequisite AS p
JOIN Course AS rc
      ON p.RequiredCourseID = rc.CourseID
LEFT JOIN Registration AS r
      ON r.StudentID = 1
     AND r.SectionID IN (
            SELECT SectionID
            FROM Section
            WHERE CourseID = rc.CourseID
        )
WHERE p.CourseID = 2;

--If all returned rows have IsGradeAcceptable = 'YES', the application can allow the registration.
--If any row has NO, the application can block the registration or show a warning.
​