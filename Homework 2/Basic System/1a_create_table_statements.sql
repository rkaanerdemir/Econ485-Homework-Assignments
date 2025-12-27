-- Optional: clean up old tables from previous tests
DROP TABLE IF EXISTS Prerequisite;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;

-- STUDENT
CREATE TABLE Student (
    StudentID      INT PRIMARY KEY,
    FirstName      VARCHAR(50) NOT NULL,
    LastName       VARCHAR(50) NOT NULL,
    Email          VARCHAR(100) UNIQUE
);

-- COURSE
CREATE TABLE Course (
    CourseID       INT PRIMARY KEY,
    CourseCode     VARCHAR(10) NOT NULL,
    CourseTitle    VARCHAR(100) NOT NULL,
    CreditsECTS    INT NOT NULL
);

-- INSTRUCTOR
CREATE TABLE Instructor (
    InstructorID   INT PRIMARY KEY,
    FirstName      VARCHAR(50) NOT NULL,
    LastName       VARCHAR(50) NOT NULL,
    Email          VARCHAR(100) UNIQUE
);

-- SECTION
CREATE TABLE Section (
    SectionID      INT PRIMARY KEY,
    CourseID       INT NOT NULL,
    InstructorID   INT NOT NULL,
    Semester       VARCHAR(10) NOT NULL,
    Year           INT NOT NULL,
    SectionNumber  VARCHAR(5) NOT NULL,
    CONSTRAINT fk_section_course
        FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    CONSTRAINT fk_section_instructor
        FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- REGISTRATION (Student“Section link)
-- Grade column will be used later in Part 2 for prerequisites.
CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY,
    StudentID      INT NOT NULL,
    SectionID      INT NOT NULL,
    Grade          CHAR(2),
    CONSTRAINT fk_registration_student
        FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    CONSTRAINT fk_registration_section
        FOREIGN KEY (SectionID) REFERENCES Section(SectionID)
);
