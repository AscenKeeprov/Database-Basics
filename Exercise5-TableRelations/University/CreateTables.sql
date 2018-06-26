USE Relations

CREATE TABLE Majors
(
	MajorID INT
		CONSTRAINT PK__Major_Id
		PRIMARY KEY (MajorID),
	[Name] VARCHAR(32) NOT NULL
		CONSTRAINT CK__Major_Name__Valid
		CHECK (LEN([Name]) > 2)
)

CREATE TABLE Subjects
(
	SubjectID INT
		CONSTRAINT PK__Subject_Id
		PRIMARY KEY (SubjectID),
	SubjectName VARCHAR(32) NOT NULL
		CONSTRAINT CK__Subject_Name__Valid
		CHECK (LEN([SubjectName]) > 1)
)

CREATE TABLE Students
(
	StudentID INT
		CONSTRAINT PK__Student_Id
		PRIMARY KEY (StudentID),
	StudentNumber CHAR(10) NOT NULL,
	StudentName VARCHAR(32) NOT NULL
		CONSTRAINT CK__Student_Name__Valid
		CHECK (LEN([StudentName]) >= 2),
	MajorID INT
		CONSTRAINT FK__Students_MajorID__Majors_MajorID
		FOREIGN KEY (MajorID)
		REFERENCES Majors(MajorID)
)

CREATE TABLE Payments
(
	PaymentID INT
		CONSTRAINT PK__Payment_Id
		PRIMARY KEY (PaymentID),
	PaymentDate DATETIME2 NOT NULL,
	PaymentAmount DECIMAL(15,2),
	StudentID INT NOT NULL
		CONSTRAINT FK__Payments_StudentID__Students_StudentID
		FOREIGN KEY (StudentID)
		REFERENCES Students(StudentID)
)

CREATE TABLE Agenda
(
	StudentID INT
		CONSTRAINT FK__Agenda_StudentId__Students_StudentId
		FOREIGN KEY (StudentID)
		REFERENCES Students(StudentID),
	SubjectID INT
		CONSTRAINT FK__Agenda_SubjectId__Subjects_SubjectID
		FOREIGN KEY (SubjectID)
		REFERENCES Subjects(SubjectID)
	CONSTRAINT PK__Agenda_StudentID_SubjectID
	PRIMARY KEY (StudentID, SubjectID)
)
