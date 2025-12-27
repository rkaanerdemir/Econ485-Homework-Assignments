CREATE TABLE Prerequisite (
    PrerequisiteID   INT PRIMARY KEY,
    CourseID         INT NOT NULL,  -- the course that has prerequisites
    RequiredCourseID INT NOT NULL,  -- the course that must be passed first
    MinimumGrade     CHAR(2) NOT NULL,
    CONSTRAINT fk_prereq_course
        FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    CONSTRAINT fk_prereq_required
        FOREIGN KEY (RequiredCourseID) REFERENCES Course(CourseID)
);

--Example rule: CS102 requires CS101 with at least grade C.

INSERT INTO Prerequisite (PrerequisiteID, CourseID, RequiredCourseID, MinimumGrade) VALUES
(1, 2, 1, 'C');  -- CS102 (2) requires CS101 (1) with minimum C

--Grades are stored in Registration.Grade. Below, some students receive grades for CS101 so that prerequisite checks have data.
?

-- Assume SectionID = 1 is the CS101 section
UPDATE Registration
SET Grade = 'B'
WHERE RegistrationID = 1;   -- student 1, CS101

UPDATE Registration
SET Grade = 'D'
WHERE RegistrationID = 5;   -- student 3, CS101

UPDATE Registration
SET Grade = 'C'
WHERE RegistrationID = 9;   -- student 5, CS101