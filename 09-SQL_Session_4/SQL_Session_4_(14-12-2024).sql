-- Add new tables to the schema
--CREATE TABLE Departments (
--    DepartmentID INT PRIMARY KEY,
--    DepartmentName VARCHAR(100)
--);

--CREATE TABLE Courses (
--    CourseID INT PRIMARY KEY,
--    CourseName VARCHAR(100)
--);

--CREATE TABLE CourseSubjects (
--    CourseSubjectID INT PRIMARY KEY,
--    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
--    SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID)
--);

--CREATE TABLE Enrollments (
--    EnrollmentID INT PRIMARY KEY,
--    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
--    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
--    EnrollmentDate DATE
--);

--CREATE TABLE Timetable (
--    TimetableID INT PRIMARY KEY,
--    SectionID INT FOREIGN KEY REFERENCES Sections(SectionID),
--    DayOfWeek VARCHAR(10),
--    StartTime TIME,
--    EndTime TIME
--);


-- Insert data into Departments table
--INSERT INTO Departments (DepartmentID, DepartmentName)
--VALUES (1, 'Computer Science'), 
--       (2, 'Mathematics'), 
--       (3, 'Engineering'),
--       (4, 'Physics'),
--       (5, 'Biology'),
--       (6, 'Chemistry'),
--       (7, 'Philosophy'),
--       (8, 'Statistics'),
--       (9, 'Economics'),
--       (10, 'History');

-- Insert data into Courses table
--INSERT INTO Courses (CourseID, CourseName)
--VALUES (1, 'Introduction to Programming'),
--       (2, 'Advanced Mathematics'),
--       (3, 'Mechanical Systems'),
--       (4, 'Artificial Intelligence'),
--       (5, 'Quantum Physics'),
--       (6, 'Organic Chemistry'),
--       (7, 'Ethics in Philosophy'),
--       (8, 'Data Analysis'),
--       (9, 'Global Economics'),
--       (10, 'World History');

-- Insert data into CourseSubjects table
--INSERT INTO CourseSubjects (CourseSubjectID, CourseID, SubjectID)
--VALUES (1, 1, 1), (2, 1, 2),
--       (3, 2, 3), (4, 2, 4),
--       (5, 3, 5), (6, 3, 6),
--       (7, 4, 7), (8, 4, 8),
--       (9, 5, 9), (10, 5, 10),
--       (11, 6, 1), (12, 6, 2),
--       (13, 7, 3), (14, 7, 4),
--       (15, 8, 5), (16, 8, 6),
--       (17, 9, 7), (18, 9, 8),
--       (19, 10, 9), (20, 10, 10);

-- Insert data into Enrollments table
--INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate)
--VALUES (1, 1, 1, '2024-09-01'),
--       (2, 2, 2, '2024-09-02'),
--       (3, 3, 3, '2024-09-03'),
--       (4, 4, 4, '2024-09-04'),
--       (5, 5, 5, '2024-09-05'),
--       (6, 6, 6, '2024-09-06'),
--       (7, 7, 7, '2024-09-07'),
--       (8, 8, 8, '2024-09-08'),
--       (9, 9, 9, '2024-09-09'),
--       (10, 10, 10, '2024-09-10');

-- Insert data into Timetable table
--INSERT INTO Timetable (TimetableID, SectionID, DayOfWeek, StartTime, EndTime)
--VALUES (1, 1, 'Monday', '09:00', '10:30'),
--       (2, 2, 'Tuesday', '11:00', '12:30'),
--       (3, 3, 'Wednesday', '14:00', '15:30'),
--       (4, 4, 'Thursday', '10:00', '11:30'),
--       (5, 5, 'Friday', '13:00', '14:30'),
--       (6, 5, 'Monday', '15:00', '16:30'),
--       (7, 7, 'Tuesday', '09:00', '10:30'),
--       (8, 8, 'Wednesday', '11:00', '12:30'),
--       (9, 9, 'Thursday', '14:00', '15:30'),
--       (10, 10, 'Friday', '10:00', '11:30');


-----------------------VIEWS-----------------------


-- Question 1: Create a view to show Student names 
--		and their Grades for each Subject
CREATE VIEW vw_st_gr AS
SELECT s.FirstName, s.LastName, g.SubjectID, g.Grade
FROM Students s
INNER JOIN Grades g ON s.StudentID = g.StudentID;

-- Insert using StudentGradesView: 
--		Add a new grade for a student
INSERT INTO Grades (StudentID ,SubjectID, Grade)
VALUES (10, 10, 'A');


-- Update using StudentGradesView: 
--		Update the grade of a student for a subject
UPDATE vw_st_gr
SET Grade = 'B'
WHERE SubjectID = 10;


-- Delete using StudentGradesView: 
--		Remove a student's grade for a subject
DELETE FROM Grades
WHERE StudentID = 10 AND SubjectID = 10;

-- Select using StudentGradesView: 
--		Retrieve all students and their grades
SELECT * FROM vw_st_gr 

-- Select using StudentGradesView: 
--		Retrieve grades for a specific subject
SELECT * FROM vw_st_gr WHERE SubjectID = 10;

-- Question 2: Create a view to show Course names and 
--		their Subjects
CREATE VIEW vw_cr_sub AS
SELECT c.CourseName, s.SubjectName
FROM Courses c
JOIN CourseSubjects cs ON c.CourseID = cs.CourseID
JOIN Subjects s ON cs.SubjectID = s.SubjectID;

-- Insert using CourseSubjectsView: 
--		Add a new subject to a course
INSERT INTO CourseSubjects(CourseSubjectID , 
		CourseID, SubjectID)
VALUES (22, 1, 10);

-- Update using CourseSubjectsView: 
--		Change a course's subject
UPDATE CourseSubjects
SET SubjectID = 11
WHERE CourseID = 1 AND SubjectID = 10;

-- Delete using CourseSubjectsView: 
--		Remove a subject from a course
DELETE FROM CourseSubjects
WHERE CourseID = 1 AND SubjectID = 11;

-- Select using CourseSubjectsView: 
--		Retrieve all courses and their subjects
SELECT * FROM vw_cr_sub;

-- Select using CourseSubjectsView: 
--		Retrieve all subjects for a specific course
SELECT *
FROM vw_cr_sub
WHERE CourseName = 'Introduction to Programming';


-- Question 3: Create a view to show Professors 
--		and the Departments they belong to
CREATE VIEW vw_pr_dep AS
SELECT p.FirstName, p.LastName, d.DepartmentName
FROM Professors p
JOIN Departments d ON p.Department = d.DepartmentName;


-- Insert using ProfessorDepartmentsView: 
--		Add a professor to a department
INSERT INTO Professors (FirstName, LastName, Department, Email)
VALUES ('John', 'Parker', 2, 'john.parker@example.com');

-- Update using ProfessorDepartmentsView: 
--		Change a professor's department


-- Select using ProfessorDepartmentsView: 
--		Retrieve all professors and their departments


-- Select using ProfessorDepartmentsView: 
--		Retrieve professors for a specific department
SELECT * FROM vw_pr_dep WHERE DepartmentName = 'Computer Science';


-- Question 4: Create a view to show Sections and 
--		the Subjects conducted in them






-- Insert using SectionSubjectsView: 
--		Add a new subject to a section



-- Update using SectionSubjectsView: 
--		Change the credits of a subject in a section




-- Delete using SectionSubjectsView: 
--		Remove a subject from a section



-- Select using SectionSubjectsView: 
--		Retrieve all sections and their subjects


-- Select using SectionSubjectsView: 
--		Retrieve subjects for a specific section



-- Question 5: Create a view to show Enrollments 
--		with Student and Course information






-- Insert using EnrollmentView: 
--		Enroll a student in a course



-- Update using EnrollmentView: Change a student's course




-- Delete using EnrollmentView: Remove an enrollment record



-- Select using EnrollmentView: Retrieve all enrollments


-- Select using EnrollmentView: 
--		Retrieve enrollments for a specific course




-- Commands to delete all views
DROP VIEW IF EXISTS vw_cr_sub;
DROP VIEW IF EXISTS vw_pr_dep;
DROP VIEW IF EXISTS vw_st_gr;






-- Question 1: Create a view to show the total number
--		of students enrolled in each course along 
--			with the course details
CREATE VIEW vw_st_enr AS
SELECT c.CourseID, c.CourseName, COUNT(e.StudentID) AS TotalStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

-- Can we INSERT into this view? 
--		NO, Beacuse we are usein a GROUP BY with AGG fn
-- Can we UPDATE this view? 
--		NO, Beacuse we are usein a GROUP BY with AGG fn
-- Can we DELETE using this view? 
--		NO, Due to aggregation

-- Select using CourseEnrollmentSummary: 
--		Retrieve all courses and their enrollment counts
SELECT * FROM vw_st_enr;

-- Select using CourseEnrollmentSummary: 
--		Retrieve courses with more than 10 enrollments
SELECT CourseName
FROM vw_st_enr
WHERE TotalStudents > 10;

-- Question 2: Create a view to show the average grade 
--		per subject and the professor teaching it
CREATE VIEW vw_sub_gr_avg AS
SELECT sub.SubjectID, sub.SubjectName, 
	(p.FirstName + ' ' + p.LastName) AS ProfessorName,
	AVG(CASE WHEN g.Grade = 'A' THEN 4 
		WHEN g.Grade = 'B' THEN 3 
		WHEN g.Grade = 'C' THEN 2
		WHEN g.Grade = 'D' THEN 1
		ELSE 0 END) AS AverageGrade
FROM Subjects sub
INNER JOIN Professors p ON sub.ProfessorID = p.ProfessorID
LEFT JOIN Grades g ON sub.SubjectID = g.SubjectID
GROUP BY sub.SubjectID, 
			sub.SubjectName,
			p.FirstName,
			p.LastName;

-- Can we INSERT into this view? 
--		
-- Can we UPDATE this view? 
--		
-- Can we DELETE using this view? 
--		

-- Select using SubjectGradeAverage: 
--		Retrieve average grades for all subjects
SELECT * FROM vw_sub_gr_avg;

-- Select using SubjectGradeAverage: 
--		Retrieve subjects with an average grade above 3.0
SELECT SubjectName
FROM vw_sub_gr_avg
WHERE AverageGrade > 3;

-- Question 3: Create a view to show sections with 
--		their total capacity and the number of students 
--			enrolled
CREATE VIEW vw_sec_sub_enr AS
SELECT sec.SectionID, sec.SectionName, sec.Capacity,
		COUNT(e.StudentID) AS EnrolledStudents
FROM Sections sec
LEFT JOIN Subjects sub ON sec.SectionID = sub.SectionID
LEFT JOIN CourseSubjects cs ON sub.SubjectID = cs.SubjectID
LEFT JOIN Enrollments e ON cs.CourseID = e.CourseID
GROUP BY sec.SectionID, sec.SectionName, sec.Capacity;




-- Can we INSERT into this view? 
--		
-- Can we UPDATE this view? 
--		
-- Can we DELETE using this view? 
--		

-- Select using SectionCapacityUsage: 
--		Retrieve all sections and their capacity usage


-- Select using SectionCapacityUsage: 
--		Retrieve sections where more than 50% capacity is used
SELECT * FROM vw_sec_sub_enr
WHERE EnrolledStudents > (Capacity / 6);


-- Question 4: Create a view to show students with their
--		courses and professors












-- Can we INSERT into this view? 
--		
-- Can we UPDATE this view? 
--		
-- Can we DELETE using this view? 
--		

-- Select using StudentCourseProfessor: 
--		Retrieve all students with their courses and professors


-- Select using StudentCourseProfessor: 
--		Retrieve data for a specific student



-- Question 5: Create a view to show professors with 
--		the number of subjects they teach and total credits










-- Can we INSERT into this view? 
--		
-- Can we UPDATE this view? 
--		
-- Can we DELETE using this view? 
--		

-- Select using ProfessorSubjectSummary: 
--		Retrieve all professors with their subject count and credits


-- Select using ProfessorSubjectSummary: 
--		Retrieve professors teaching more than 3 subjects



-- Commands to delete all views










