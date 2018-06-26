CREATE TABLE Categories
(
	Id INT IDENTITY
		CONSTRAINT PK__Category_Id
		PRIMARY KEY (Id),
	CategoryName NVARCHAR(50) NOT NULL
		CONSTRAINT UQ__Category_Name
		UNIQUE (CategoryName),
	DailyRate DECIMAL(3,2) NOT NULL,
	WeeklyRate DECIMAL(4,2) NOT NULL,
	MonthlyRate DECIMAL(5,2) NOT NULL,
	WeekendRate DECIMAL(3,2) NOT NULL
)

CREATE TABLE Cars
(
	Id INT IDENTITY
		CONSTRAINT PK__Car_Id
		PRIMARY KEY (Id),
	PlateNumber NVARCHAR(10) NOT NULL
		CONSTRAINT CK__Car_PlateNumber__Valid
		CHECK (LEN(PlateNumber) >= 6)
		CONSTRAINT UQ__Car_PlateNumber
		UNIQUE (PlateNumber),
	Manufacturer NVARCHAR(32)
		CONSTRAINT DF__Car_Manufacturer
		DEFAULT 'Unknown',
	Model NVARCHAR(32)
		CONSTRAINT DF__Car_Model
		DEFAULT 'Unknown',
	CarYear SMALLINT
		CONSTRAINT CK__Car_Year__Valid
		CHECK (CarYear >= 1993 AND CarYear <= YEAR(GETDATE())),
	CategoryId INT NOT NULL
		CONSTRAINT FK__Car_CategoryId__Categories_Id
		FOREIGN KEY (CategoryId)
		REFERENCES Categories(Id),
	Doors TINYINT NOT NULL
		CONSTRAINT CK__Car_Doors__Valid
		CHECK (Doors >= 1 AND Doors <= 6),
	Picture VARBINARY(MAX)
		CONSTRAINT CK__Car_Picture__Max_1MB
		CHECK (DATALENGTH(Picture) <= 1048576),
	Condition NVARCHAR(256),
	Available BIT NOT NULL
		CONSTRAINT DF__Car_Available
		DEFAULT 1
)

CREATE TABLE Employees
(
	Id INT IDENTITY
		CONSTRAINT PK__Employee_Id
		PRIMARY KEY (Id),
	FirstName NVARCHAR(32) NOT NULL,
	LastName NVARCHAR(32) NOT NULL,
	Title NVARCHAR(32) NOT NULL,
	Notes NVARCHAR(256)
)

CREATE TABLE Customers
(
	Id INT IDENTITY
		CONSTRAINT PK__Customer_Id
		PRIMARY KEY (Id),
	DriverLicenceNumber VARCHAR(10) NOT NULL
		CONSTRAINT CK__Customer_DriverLicenceNumber__Valid
		CHECK (LEN(DriverLicenceNumber) >= 6),
	FullName NVARCHAR(64) NOT NULL,
	[Address] NVARCHAR(96),
	City NVARCHAR(32),
	ZIPCode VARCHAR(10),
	Notes NVARCHAR(128)
)

CREATE TABLE RentalOrders
(
	Id INT IDENTITY
		CONSTRAINT PK__RentalOrder_Id
		PRIMARY KEY (Id),
	EmployeeId INT NOT NULL
		CONSTRAINT FK__RentalOrder_EmployeeId__Employees_Id
		FOREIGN KEY (EmployeeId)
		REFERENCES Employees(Id),
	CustomerId INT NOT NULL
		CONSTRAINT FK__RentalOrder_CustomerId__Customers_Id
		FOREIGN KEY (CustomerId)
		REFERENCES Customers(Id),
	CarId INT NOT NULL
		CONSTRAINT FK__RentalOrder_CarId__Cars_Id
		FOREIGN KEY (CarId)
		REFERENCES Cars(Id),
	TankLevel TINYINT NOT NULL
		CONSTRAINT CK__RentalOrder_TankLevel__Valid
		CHECK (TankLevel >= 0 AND TankLevel <= 100),
	KilometrageStart DECIMAL(7,1)
		CONSTRAINT CK__Odometer_Start__Valid
		CHECK (KilometrageStart >= 0 AND KilometrageStart <= 999999),
	KilometrageEnd DECIMAL(7,1)
		CONSTRAINT CK__Odometer_End__Valid
		CHECK (KilometrageEnd >= 0 AND KilometrageEnd <= 999999),
	TotalKilometrage AS (KilometrageEnd - KilometrageStart),
	StartDate DATETIME2 NOT NULL
		CONSTRAINT CK__RentalOrder_StartDate__Valid
		CHECK (DATEDIFF(MINUTE, StartDate, GETDATE()) > 0),
	EndDate DATETIME2
		CONSTRAINT CK__RentalOrder_EndDate__Valid
		CHECK (DATEDIFF(MINUTE, EndDate, GETDATE()) > 0),
	TotalDays AS DATEDIFF(DAY, StartDate, EndDate),
	RateApplied DECIMAL(5,2) NOT NULL,
	TaxRate AS (RateApplied * 0.02),
	OrderStatus CHAR(6)
		CONSTRAINT CK__RentalOrder_Status__Valid
		CHECK (OrderStatus = 'Active'
		 OR OrderStatus = 'Cancel'
		 OR OrderStatus = 'Closed'),
	Notes NVARCHAR(128)
)
