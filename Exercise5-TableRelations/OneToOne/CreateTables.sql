CREATE DATABASE Relations

USE Relations

CREATE TABLE Passports
(
	PassportID INT IDENTITY(101,1)
		CONSTRAINT PK__Passport_Id
		PRIMARY KEY (PassportID),
	PassportNumber CHAR(8) NOT NULL
		CONSTRAINT CK__Passport_Number__Valid
		CHECK (PassportNumber LIKE '%[A-Z0-9]%')
		CONSTRAINT UQ__Passport_Number
		UNIQUE (PassportNumber)
)

CREATE TABLE Persons
(
	PersonID INT IDENTITY,
	FirstName NVARCHAR(64) NOT NULL,
	Salary DECIMAL(15,2) NOT NULL
		CONSTRAINT CK__Person_Salary__Valid
		CHECK (Salary > 0),
	PassportID INT NOT NULL
		CONSTRAINT UQ__Person_PassportID
		UNIQUE (PassportID)
)

ALTER TABLE Persons
ADD CONSTRAINT PK__Person_Id
PRIMARY KEY (PersonID)

ALTER TABLE Persons
ADD CONSTRAINT FK__Person_PassportID__Passports_PassportID
FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID)
