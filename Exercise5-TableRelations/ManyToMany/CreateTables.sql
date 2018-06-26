USE Relations

CREATE TABLE Exams
(
	ExamID INT IDENTITY(101,1),
	[Name] VARCHAR(32) NOT NULL
		CONSTRAINT UQ__Exam_Name
		UNIQUE ([Name])
)

CREATE TABLE Students
(
	StudentID INT IDENTITY,
	[Name] NVARCHAR(32) NOT NULL
		CONSTRAINT CK__Student_Name__Valid
		CHECK (LEN([Name]) > 2)
)

CREATE TABLE StudentsExams
(
	StudentID INT NOT NULL
		CONSTRAINT CK__StudentsExams_StudentID__Valid
		CHECK (StudentID >= 1),
	ExamID INT NOT NULL
		CONSTRAINT CK__StudentsExams_ExamID__Valid
		CHECK (ExamID >= 101),
	CONSTRAINT UQ__StudentsExams__Record
	UNIQUE (StudentID, ExamID)
)

ALTER TABLE Exams
ADD CONSTRAINT PK__Exam_Id
	PRIMARY KEY (ExamID)

ALTER TABLE Students
ADD CONSTRAINT PK__Student_Id
	PRIMARY KEY (StudentID)

ALTER TABLE StudentsExams
ADD CONSTRAINT PK__StudentsExams_StudentId_ExamID
	PRIMARY KEY (StudentID, ExamID),
	CONSTRAINT FK__StudentsExams_StudentID__Students_StudentID
	FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK__StudentsExams_ExamID__Exams_ExamID
	FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
