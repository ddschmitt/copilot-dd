-- define a select statement to get all students enrolled in a course
SELECT s.first_name, s.last_name, s.email, s.city, s.state, s.zip_code
FROM courses.students s
JOIN courses.registrations r ON s.student_id = r.student_id
JOIN courses.registration_items ri ON r.registration_id = ri.registration_id
JOIN curriculum.subjects c ON ri.course_id = c.course_id
WHERE c.course_name = 'C# Programming';
-- define a select statement to get all courses a student is enrolled in
SELECT c.course_name, c.course_description, c.course_hours
FROM curriculum.subjects c
JOIN courses.registration_items ri ON c.course_id = ri.course_id
JOIN courses.registrations r ON ri.registration_id = r.registration_id
JOIN courses.students s ON r.student_id = s.student_id
WHERE s.email = '

-- write an index to improve the performance of the query
CREATE INDEX idx_student_email ON courses.students (email);

-- define a table for student attendance to capture attendance by class
CREATE TABLE courses.attendance (
    attendance_id INT IDENTITY (1, 1) PRIMARY KEY,
    registration_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    attendance_status tinyint NOT NULL,
    -- Attendance status: 1 = Present; 2 = Absent; 3 = Late; 4 = Excused
    FOREIGN KEY (registration_id) REFERENCES courses.registrations (registration_id) ON DELETE CASCADE ON UPDATE CASCADE
);

--define a stored procedure to get course enrollment by location
CREATE PROCEDURE GetCourseEnrollmentByLocation
    @location_id INT
AS
BEGIN
    SELECT c.course_name, COUNT(r.registration_id) AS enrollment
    FROM curriculum.subjects c
    JOIN courses.registration_items ri ON c.course_id = ri.course_id
    JOIN courses.registrations r ON ri.registration_id = r.registration_id
    WHERE r.location_id = @location_id
    GROUP BY c.course_name;
END;

-- define a trigger to update the completion date of a registration when all items are completed
CREATE TRIGGER UpdateCompletionDate
ON courses.registration_items
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE courses.registrations
    SET completion_date = GETDATE()
    WHERE registration_id IN (SELECT registration_id FROM inserted)
    AND NOT EXISTS (
        SELECT 1
        FROM courses.registration_items ri
        WHERE ri.registration_id = courses.registrations.registration_id
        AND ri.quantity > 0
    );
END;

--define a stored procedure to get instructor details associated with a location
include instructor details, location details, and courses associated with the instructor
use instructor_id as the input parameter
CREATE PROCEDURE GetInstructorDetailsByLocation
    @instructor_id INT
AS
BEGIN
    SELECT s.first_name, s.last_name, s.email, s.phone, l.location_name, l.street, l.city, l.state, l.zip_code, c.course_name
    FROM courses.staffs s
    JOIN courses.locations l ON s.location_id = l.location_id
    JOIN courses.registrations r ON s.staff_id = r.staff_id
    JOIN courses.registration_items ri ON r.registration_id = ri.registration_id
    JOIN curriculum.subjects c ON ri.course_id = c.course_id
    WHERE s.instructor_id = @instructor_id;
END;

SELECT * 
FROM courses.registrations 
WHERE registration_date >= '2023-09-01' AND registration_date < '2023-10-01';

select * from courses.registrations where year(registration_date) = 2023 and month(registration_date) = 9;