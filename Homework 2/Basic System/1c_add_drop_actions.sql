-- At least 3 students drop one section each (DELETE = drop)
DELETE FROM Registration
WHERE RegistrationID IN (3, 7, 13);

-- New add actions (INSERT = add)
INSERT INTO Registration (RegistrationID, StudentID, SectionID, Grade) VALUES
(16, 2, 3, NULL),  -- Zeynep adds MATH101-01
(17, 4, 2, NULL),  -- Elif adds CS102-01
(18, 8, 1, NULL);  -- Mert adds CS101-01

--This satisfies the requirement of minimum 3 courses, sections, 10 students, and 15 registrations.--