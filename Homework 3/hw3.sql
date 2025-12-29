-- -------------------------------------------------------------
-- Task 1 – List Students and Their Registered Sections
-- -------------------------------------------------------------
-- Show: student name, course code, section number (and some
-- extra helpful fields).

SELECT 
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseCode,
    c.CourseTitle,
    sec.SectionNumber,
    sec.Semester,
    sec.Year
FROM Student AS s
JOIN Registration AS r
      ON s.StudentID = r.StudentID
JOIN Section AS sec
      ON r.SectionID = sec.SectionID
JOIN Course AS c
      ON sec.CourseID = c.CourseID
ORDER BY s.StudentID, c.CourseCode;

-- -------------------------------------------------------------
-- Task 2 – Show Courses with Total Student Counts
-- -------------------------------------------------------------
-- List all courses with the total number of students registered
-- in all sections. Use LEFT JOIN so that courses with zero
-- registrations are also shown.

SELECT 
    c.CourseID,
    c.CourseCode,
    c.CourseTitle,
    COUNT(r.StudentID) AS TotalStudents
FROM Course AS c
LEFT JOIN Section AS sec
       ON c.CourseID = sec.CourseID
LEFT JOIN Registration AS r
       ON sec.SectionID = r.SectionID
GROUP BY c.CourseID, c.CourseCode, c.CourseTitle
ORDER BY c.CourseCode;

-- -------------------------------------------------------------
-- Task 3 – List All Prerequisites for Each Course
-- -------------------------------------------------------------
-- For each course, list its prerequisite courses and the minimum
-- required grade. Courses without prerequisites are included.

SELECT
    c.CourseCode       AS Course,
    c.CourseTitle      AS CourseTitle,
    rc.CourseCode      AS PrerequisiteCourse,
    rc.CourseTitle     AS PrerequisiteTitle,
    p.MinimumGrade
FROM Course AS c
LEFT JOIN Prerequisite AS p
       ON c.CourseID = p.CourseID
LEFT JOIN Course AS rc
       ON p.RequiredCourseID = rc.CourseID
ORDER BY c.CourseCode, rc.CourseCode;

-- -------------------------------------------------------------
-- Task 4 – Identify Students Eligible to Take a Course
-- -------------------------------------------------------------
-- A student is eligible for a target course if:
--  (1) They have completed all prerequisite courses;
--  (2) Their grade in each prerequisite meets or exceeds the
--      minimum required grade;
--  (3) They are not already registered for the target course.
--
-- Example: target course = CourseID = 2 (e.g. CS102).
-- You can change 2 to any other CourseID if needed.

SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    t.CourseCode            AS TargetCourse,
    rc.CourseCode           AS PrerequisiteCourse,
    r.Grade                 AS StudentGrade,
    p.MinimumGrade,
    CASE
        WHEN r.Grade IS NULL 
             OR (p.MinimumGrade = 'C' AND r.Grade NOT IN ('A','B','C'))
             OR (p.MinimumGrade = 'B' AND r.Grade NOT IN ('A','B'))
             OR (p.MinimumGrade = 'A' AND r.Grade != 'A')
        THEN 'NOT ELIGIBLE'
        ELSE 'ELIGIBLE'
    END AS EligibilityStatus
FROM Student AS s
CROSS JOIN Course AS t
LEFT JOIN Prerequisite AS p
       ON t.CourseID = p.CourseID
LEFT JOIN Course AS rc
       ON p.RequiredCourseID = rc.CourseID
LEFT JOIN Section AS sec
       ON sec.CourseID = rc.CourseID
LEFT JOIN Registration AS r
       ON r.StudentID = s.StudentID AND r.SectionID = sec.SectionID
WHERE t.CourseID = 2
  AND s.StudentID NOT IN (
        SELECT r2.StudentID
        FROM Registration r2
        JOIN Section sec2 ON r2.SectionID = sec2.SectionID
        WHERE sec2.CourseID = 2
      )
ORDER BY StudentName, rc.CourseCode;


-- -------------------------------------------------------------
-- Task 5 – Detect Students Who Registered Without
--          Meeting Prerequisites
-- -------------------------------------------------------------
-- A prerequisite violation occurs when:
--  (1) A student is registered for a course that has prerequisites;
--  (2) The student either did not complete the prerequisite course
--      at all, or completed it with a grade below the minimum.
--
-- The query returns: student name, target course, missing or
-- failed prerequisite, student's grade (if any), and minimum
-- required grade.

SELECT
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseCode          AS TargetCourse,
    rc.CourseCode         AS MissingOrFailedPrerequisite,
    r2.Grade              AS StudentGrade,
    p.MinimumGrade
FROM Registration AS reg
JOIN Student AS s
     ON reg.StudentID = s.StudentID
JOIN Section AS sec
     ON reg.SectionID = sec.SectionID
JOIN Course AS c
     ON sec.CourseID = c.CourseID
JOIN Prerequisite AS p
     ON c.CourseID = p.CourseID
JOIN Course AS rc
     ON p.RequiredCourseID = rc.CourseID
LEFT JOIN Section AS sec2
     ON rc.CourseID = sec2.CourseID
LEFT JOIN Registration AS r2
     ON r2.StudentID = s.StudentID AND r2.SectionID = sec2.SectionID
WHERE (r2.Grade IS NULL)  -- prerequisite never taken
   OR (p.MinimumGrade = 'C' AND r2.Grade NOT IN ('A','B','C'))
   OR (p.MinimumGrade = 'B' AND r2.Grade NOT IN ('A','B'))
   OR (p.MinimumGrade = 'A' AND r2.Grade != 'A')
ORDER BY StudentName, c.CourseCode;