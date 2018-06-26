USE Relations

CREATE TABLE Teachers
(
	TeacherID INT IDENTITY(101,1),
	[Name] VARCHAR(32) NOT NULL,
	ManagerID INT
)

ALTER TABLE Teachers
ADD CONSTRAINT PK__Teacher_Id
	PRIMARY KEY (TeacherID),
	CONSTRAINT FK__Teachers_ManagerID__Teachers_TeacherID
	FOREIGN KEY (ManagerID)	REFERENCES Teachers(TeacherID)
