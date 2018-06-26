CREATE TABLE Employees
(
	Id INT IDENTITY
		CONSTRAINT PK__Employee_Id
		PRIMARY KEY (Id),
	FirstName NVARCHAR(64) NOT NULL,
	LastName NVARCHAR(64) NOT NULL,
	Title VARCHAR(32) NOT NULL,
	Notes NVARCHAR(128)
)

CREATE TABLE Customers
(
	AccountNumber VARCHAR(12) NOT NULL
		CONSTRAINT PK__Customer_AccountNumber
		PRIMARY KEY (AccountNumber)
		CONSTRAINT CK__Customer_AccountNumber__Valid
		CHECK (PATINDEX('%[^A-Z0-9]%', AccountNumber) = 0),
	FirstName NVARCHAR(64) NOT NULL,
	LastName NVARCHAR(64) NOT NULL,
	PhoneNumber NUMERIC(16),
	EmergencyName NVARCHAR(64) NOT NULL,
	EmergencyNumber NUMERIC(16) NOT NULL,
	Notes NVARCHAR(128)
)

CREATE TABLE RoomStatus
(
	RoomStatus VARCHAR(16)
		CONSTRAINT PK__Room_Status
		PRIMARY KEY (RoomStatus),
	Notes NVARCHAR(128)
)

CREATE TABLE RoomTypes
(
	RoomType VARCHAR(16)
		CONSTRAINT PK__Room_Type
		PRIMARY KEY (RoomType),
	Notes NVARCHAR(64)
)

CREATE TABLE BedTypes
(
	BedType VARCHAR(16)
		CONSTRAINT PK__Bed_Type
		PRIMARY KEY (BedType),
	Notes NVARCHAR(64)
)

CREATE TABLE Rooms
(
	RoomNumber INT IDENTITY
		CONSTRAINT PK__Room_Number
		PRIMARY KEY (RoomNumber),
	RoomType VARCHAR(16) NOT NULL
		CONSTRAINT FK__Room_Type__RoomTypes
		FOREIGN KEY (RoomType)
		REFERENCES RoomTypes(RoomType),
	BedType VARCHAR(16) NOT NULL
		CONSTRAINT FK__Room_BedType__BedTypes
		FOREIGN KEY (BedType)
		REFERENCES BedTypes(BedType),
	Rate DECIMAL(4,2) NOT NULL
		CONSTRAINT CK__Room_Rate__Valid
		CHECK (Rate >= 30),
	RoomStatus VARCHAR(16) NOT NULL
		CONSTRAINT FK__Room_Status__RoomStatus
		FOREIGN KEY (RoomStatus)
		REFERENCES RoomStatus(RoomStatus),
	Notes NVARCHAR(128)
)

CREATE TABLE Payments
(
	Id INT IDENTITY
		CONSTRAINT PK__Payment_Id
		PRIMARY KEY (Id),
	EmployeeId INT NOT NULL
		CONSTRAINT FK__Payment_EmployeeId__Employees_Id
		FOREIGN KEY (EmployeeId)
		REFERENCES Employees(Id),
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber VARCHAR(12) NOT NULL
		CONSTRAINT FK__Payment_AccountNumber__Customers_AccountNumber
		FOREIGN KEY (AccountNumber)
		REFERENCES Customers(AccountNumber),
	FirstDateOccupied DATETIME2 NOT NULL,
	LastDateOccupied DATETIME2 NOT NULL
		CONSTRAINT CK__Payment_LastDateOccupied__Valid
		CHECK (DATEDIFF(HOUR, FirstDateOccupied, LastDateOccupied) > 0
		 AND DATEDIFF(HOUR, LastDateOccupied, DATEPART(HOUR, GETDATE())) > 0),
	TotalDays AS DATEDIFF(DAY, FirstDateOccupied, LastDateOccupied),
	AmountCharged DECIMAL(8,2) NOT NULL
		CONSTRAINT CK__Payment_AmountCharged__Valid
		CHECK (AmountCharged > 0),
	TaxRate DECIMAL(3,2) NOT NULL
		CONSTRAINT CK__Payment_TaxRate__Valid
		CHECK (TaxRate > 0 AND TaxRate < 1),
	TaxAmount AS AmountCharged * TaxRate,
	PaymentTotal AS AmountCharged + TaxAmount,
	Notes NVARCHAR(256)
)

CREATE TABLE Occupancies
(
	Id INT IDENTITY
		CONSTRAINT PK__Occupancy_Id
		PRIMARY KEY (Id),
	EmployeeId INT NOT NULL
		CONSTRAINT FK__Payment_EmployeeId__Employees_Id
		FOREIGN KEY (EmployeeId)
		REFERENCES Employees(Id),
	DateOccupied DATETIME2 NOT NULL,
	AccountNumber VARCHAR(12) NOT NULL
		CONSTRAINT FK__Occupancy_AccountNumber__Customers_AccountNumber
		FOREIGN KEY (AccountNumber)
		REFERENCES Customers(AccountNumber),
	RoomNumber INT NOT NULL
		CONSTRAINT FK__Occupancy_RoomNumber__Rooms_RoomNumber
		FOREIGN KEY (RoomNumber)
		REFERENCES Rooms(RoomNumber),
	RateApplied DECIMAL(4,2) NOT NULL
		CONSTRAINT CK__Occupancy_RateApplied__Valid
		CHECK (RateApplied >= 30),
	PhoneCharge DECIMAL(4,2),
	Notes NVARCHAR(256)
)
