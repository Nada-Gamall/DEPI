-- 1. Date, Time Functions

-- Q1: How can you display the current date and time when running a query?
SELECT GETDATE() AS CurrentDateTime;

-- Q2: How can you calculate the duration between two times, 
--		like the start and end times in the Timetable table?
SELECT DATEDIFF(MINUTE, StartTime, EndTime) AS SessionDurationMin
FROM Timetable;


-- Q3: How can you add 7 days to the EnrollmentDate in the Enrollments table to show 
--   a hypothetical follow-up date?
SELECT EnrollmentDate, StudentID, DATEADD(DAY, 7, EnrollmentDate) AS FollowUp
FROM Enrollments;



-- 2. Extract Portions from a Date

-- Q1: How can you extract the year, month, and day separately from the 
--   BirthDate in the Students table?
SELECT StudentID, BirthDate,
		YEAR(BirthDate) AS BirthYear,
		MONTH(BirthDate) AS BirthMonth,
		DAY(BirthDate) AS BirthDay
FROM Students;


-- Q2: How can you get all students born in the month of January?
SELECT StudentID, FirstName, LastName
FROM Students
WHERE MONTH(BirthDate) = 1;



-- Q3: How can you determine the day of the week for each EnrollmentDate 
--   in the Enrollments table?
SELECT EnrollmentID, EnrollmentDate,
		DATENAME(WEEKDAY, EnrollmentDate) AS DayOfWeek
FROM Enrollments;


-- 3. Selecting Columns Based on Arithmetic Operations on Dates

-- Q1: How can you retrieve all enrollments made in the last 30 days?
SELECT EnrollmentID, StudentID, EnrollmentDate
FROM Enrollments
WHERE DATEDIFF(DAY, EnrollmentDate, GETDATE()) <= 100;


-- Q2: How can you find the average age of all students based on their BirthDate?
SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) AS AverageAge
FROM Students;



-- Q3: How can you list students whose BirthDate occurred more than 10,000 days ago?
SELECT StudentID, FirstName, LastName, BirthDate
FROM Students
WHERE DATEDIFF(DAY, BirthDate, GETDATE()) > 1000;



-- 4. Examples of Special Registers

-- Q1: How can you retrieve the current user and current server name?
SELECT SUSER_NAME() AS CurrentUSER, @@SERVERNAME AS ServerName;



-- Q2: How can you display the session ID and current database name?
SELECT @@SPID AS SessionID, DB_NAME() AS DatabaseName;



-- Q3: How can you list all records in the Timetable table alongside the current date 
--   and time?
SELECT TimetableID, SectionID, StartTime, EndTime,
		GETDATE() AS CurrentTime
FROM Timetable;



SELECT TOP 100 * FROM Students




-- Create a procedure that retrieves student details who are enrolled in a 
--		specific course, using the Enrollments, Students, and Courses tables.
USE foe_db;
GO

CREATE PROCEDURE GetStudentByCourseID
	@CourseID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName, e.EnrollmentDate
	FROM Students s
	INNER JOIN Enrollments e ON s.StudentID = e.StudentID
	INNER JOIN Courses c ON e.CourseID = c.CourseID
	WHERE c.CourseID = @CourseID;
END;
GO



EXEC GetStudentByCourseID @CourseID = 4;