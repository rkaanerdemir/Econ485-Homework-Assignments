-- INSTRUCTOR
INSERT INTO Instructor (InstructorID, FirstName, LastName, Email) VALUES
(1, 'Ahmet', 'Yilmaz', 'ahmet.yilmaz@uni.edu'),
(2, 'Ayse',  'Demir',  'ayse.demir@uni.edu');

-- COURSE (at least 3 courses)
INSERT INTO Course (CourseID, CourseCode, CourseTitle, CreditsECTS) VALUES
(1, 'CS101',   'Introduction to Programming', 6),
(2, 'CS102',   'Data Structures',             6),
(3, 'MATH101', 'Calculus I',                  6);

-- SECTION (each course has at least 1 section)
INSERT INTO Section (SectionID, CourseID, InstructorID, Semester, Year, SectionNumber) VALUES
(1, 1, 1, 'Fall', 2025, '01'),  -- CS101-01
(2, 2, 1, 'Fall', 2025, '01'),  -- CS102-01
(3, 3, 2, 'Fall', 2025, '01');  -- MATH101-01

-- STUDENT (at least 10 students)
INSERT INTO Student (StudentID, FirstName, LastName, Email) VALUES
(1, 'Ali',    'Kaya',   'ali.kaya@uni.edu'),
(2, 'Zeynep', 'Celik',  'zeynep.celik@uni.edu'),
(3, 'Mehmet', 'Arslan', 'mehmet.arslan@uni.edu'),
(4, 'Elif',   'Aydin',  'elif.aydin@uni.edu'),
(5, 'Deniz',  'Kurt',   'deniz.kurt@uni.edu'),
(6, 'Can',    'Oz',     'can.oz@uni.edu'),
(7, 'Ece',    'Bulut',  'ece.bulut@uni.edu'),
(8, 'Mert',   'Sari',   'mert.sari@uni.edu'),
(9, 'Selin',  'Tuna',   'selin.tuna@uni.edu'),
(10,'Emre',   'Aksoy',  'emre.aksoy@uni.edu');

-- REGISTRATION (initial registrations, at least 15 total)
INSERT INTO Registration (RegistrationID, StudentID, SectionID, Grade) VALUES
(1,  1, 1, NULL),
(2,  1, 3, NULL),
(3,  2, 1, NULL),
(4,  2, 2, NULL),
(5,  3, 1, NULL),
(6,  3, 2, NULL),
(7,  4, 1, NULL),
(8,  4, 3, NULL),
(9,  5, 1, NULL),
(10, 5, 3, NULL),
(11, 6, 2, NULL),
(12, 7, 2, NULL),
(13, 8, 3, NULL),
(14, 9, 3, NULL),
(15,10,1, NULL);
