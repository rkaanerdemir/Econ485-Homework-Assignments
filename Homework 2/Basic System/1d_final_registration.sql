SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseCode,
    c.CourseTitle,
    sec.SectionNumber,
    sec.Semester,
    sec.Year
FROM Registration AS r
JOIN Student   AS s   ON r.StudentID = s.StudentID
JOIN Section   AS sec ON r.SectionID = sec.SectionID
JOIN Course    AS c   ON sec.CourseID = c.CourseID
ORDER BY s.StudentID, c.CourseCode;

--This query shows student name, course code, section number, and other useful information as required.
