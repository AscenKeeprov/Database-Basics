USE WMS

CREATE TABLE Clients
(
	ClientId INT IDENTITY
		CONSTRAINT PK__Client_Id
		PRIMARY KEY (ClientId),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone CHAR(12) NOT NULL
)

CREATE TABLE Mechanics
(
	MechanicId INT IDENTITY
		CONSTRAINT PK__Mechanic_Id
		PRIMARY KEY (MechanicId),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	[Address] VARCHAR(255)
)

CREATE TABLE Models
(
	ModelId INT IDENTITY
		CONSTRAINT PK__Model_Id
		PRIMARY KEY (ModelId),
	[Name] VARCHAR(50) NOT NULL
		CONSTRAINT UQ__Model_Name
		UNIQUE ([Name])
)

CREATE TABLE Jobs
(
	JobId INT IDENTITY
		CONSTRAINT PK__Job_Id
		PRIMARY KEY (JobId),
	ModelId INT NOT NULL
		CONSTRAINT FK__Jobs_ModelId__Models_Id
		FOREIGN KEY (ModelId) REFERENCES Models(ModelId),
	[Status] VARCHAR(11) NOT NULL
		CONSTRAINT CK__Job_Status
		CHECK ([Status] IN ('Pending', 'In Progress', 'Finished'))
		CONSTRAINT DF__Job_Status
		DEFAULT ('Pending'),
	ClientId INT NOT NULL
		CONSTRAINT FK__Jobs_ClientId__Clients_Id
		FOREIGN KEY (ClientId) REFERENCES Clients(ClientId),
	MechanicId INT
		CONSTRAINT FK__Jobs_MechanicId__Mechanics_Id
		FOREIGN KEY (MechanicId) REFERENCES Mechanics(MechanicId),
	IssueDate DATE NOT NULL,
	FinishDate DATE
)

CREATE TABLE Orders
(
	OrderId INT IDENTITY
		CONSTRAINT PK__Order_Id
		PRIMARY KEY (OrderId),
	JobId INT NOT NULL
		CONSTRAINT FK__Orders_JobId__Jobs_Id
		FOREIGN KEY (JobId) REFERENCES Jobs(JobId),
	IssueDate DATE,
	Delivered BIT NOT NULL
		CONSTRAINT DF__Orders_Delivered
		DEFAULT (0)
)

CREATE TABLE Vendors
(
	VendorId INT IDENTITY
		CONSTRAINT PK__Vendor_Id
		PRIMARY KEY (VendorId),
	[Name] VARCHAR(50) NOT NULL
		CONSTRAINT UQ__Vendor_Name
		UNIQUE ([Name])
)

CREATE TABLE Parts
(
	PartId INT IDENTITY
		CONSTRAINT PK__Part_Id
		PRIMARY KEY (PartId),
	SerialNumber VARCHAR(50) NOT NULL
		CONSTRAINT UQ__Part_SerialNumber
		UNIQUE (SerialNumber),
	[Description] VARCHAR(255),
	Price DECIMAL(6,2) NOT NULL
		CONSTRAINT CK__Part_Price__Positive
		CHECK (Price > 0),
	VendorId INT NOT NULL
		CONSTRAINT FK__Parts_VendorId__Vendors_Id
		FOREIGN KEY (VendorId) REFERENCES Vendors(VendorId),
	StockQty INT NOT NULL
		CONSTRAINT CK__Part_StockQty__NonNegative
		CHECK (StockQty >= 0)
		CONSTRAINT DF__Part_StockQty
		DEFAULT (0)
)

CREATE TABLE OrderParts
(
	OrderId INT NOT NULL
		CONSTRAINT FK__OrderParts_OrderId__Orders_Id
		FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
	PartId INT NOT NULL
		CONSTRAINT FK__OrderParts_PartId__Parts_Id
		FOREIGN KEY (PartId) REFERENCES Parts(PartId),
	Quantity INT NOT NULL
		CONSTRAINT CK__OrderPart_Quantity__Positive
		CHECK (Quantity > 0)
		CONSTRAINT DF__OrderPart_Quantity
		DEFAULT (1),
	CONSTRAINT PK__OrderParts__OrderId_PartId
	PRIMARY KEY (OrderId, PartId)
)

CREATE TABLE PartsNeeded
(
	JobId INT NOT NULL
		CONSTRAINT FK__PartsNeeded_JobId__Jobs_Id
		FOREIGN KEY (JobId) REFERENCES Jobs(JobId),
	PartId INT NOT NULL
		CONSTRAINT FK__PartsNeeded_PartId__Parts_Id
		FOREIGN KEY (PartId) REFERENCES Parts(PartId),
	Quantity INT NOT NULL
		CONSTRAINT CK__PartsNeeded_Quantity__Positive
		CHECK (Quantity > 0)
		CONSTRAINT DF__PartsNeeded_Quantity
		DEFAULT (1),
	CONSTRAINT PK__PartsNeeded__JobId_PartId
	PRIMARY KEY (JobId, PartId)
)
