USE Relations

CREATE TABLE Manufacturers
(
	ManufacturerID SMALLINT IDENTITY,
	[Name] NVARCHAR(16) NOT NULL
		CONSTRAINT CK__Manufacturer_Name__Valid
		CHECK ([Name] LIKE '%[A-Za-z]%')
		CONSTRAINT UQ__Manufacturer_Name
		UNIQUE ([Name]),
	EstablishedOn DATETIME2
)

CREATE TABLE Models
(
	ModelID INT IDENTITY(101,1)
		CONSTRAINT CK__Model_Id__Valid
		CHECK (ModelID > 100),
	[Name] VARCHAR(16) NOT NULL
		CONSTRAINT CK__Model_Name__Valid
		CHECK ([Name] LIKE '%[A-Za-z0-9]%')
		CONSTRAINT UQ__Model_Name
		UNIQUE ([Name]),
	ManufacturerID SMALLINT NOT NULL
		CONSTRAINT CK__Model_ManufacturerId__Valid
		CHECK (ManufacturerID > 0)
)

ALTER TABLE Manufacturers
ADD CONSTRAINT PK__Manufacturer_Id
PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
ADD CONSTRAINT PK__Model_Id
PRIMARY KEY (ModelID)

ALTER TABLE Models
ADD CONSTRAINT FK__Model_ManufacturerID__Manufacturers_ManufacturerID
FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)
