USE Relations

CREATE TABLE Cities
(
	CityID INT NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Customers
(
	CustomerID INT NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	Birthday DATE NOT NULL,
	CityID INT NOT NULL
)

CREATE TABLE Orders
(
	OrderID INT NOT NULL,
	CustomerID INT NOT NULL
)

CREATE TABLE ItemTypes
(
	ItemTypeID INT NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Items
(
	ItemID INT NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	ItemTypeID INT NOT NULL
)

CREATE TABLE OrderItems
(
	OrderID INT NOT NULL,
	ItemID INT NOT NULL
)

ALTER TABLE Cities
ADD CONSTRAINT PK__City_Id
	PRIMARY KEY (CityID)

ALTER TABLE Customers
ADD CONSTRAINT PK__Customer_Id
	PRIMARY KEY (CustomerID),
	CONSTRAINT CK__Customer_Name__Valid
	CHECK (LEN([Name]) > 2),
	CONSTRAINT FK__Customers_CityId__Cities_CityId
	FOREIGN KEY (CityID)
	REFERENCES Cities(CityID)

ALTER TABLE Orders
ADD CONSTRAINT PK__Order_Id
	PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders_CustomerId__Customers_CustomerId
	FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID)

ALTER TABLE ItemTypes
ADD CONSTRAINT PK__ItemType_Id
	PRIMARY KEY (ItemTypeID),
	CONSTRAINT CK__ItemType_Name__Valid
	CHECK (LEN([Name]) > 2)

ALTER TABLE Items
ADD CONSTRAINT PK__Item_Id
	PRIMARY KEY (ItemID),
	CONSTRAINT CK__Item_Name__Valid
	CHECK (LEN([Name]) > 2),
	CONSTRAINT FK__Items_ItemTypeId__ItemTypes_ItemTypeId
	FOREIGN KEY (ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)

ALTER TABLE OrderItems
ADD CONSTRAINT PK__OrderItems_OrderID_ItemID
	PRIMARY KEY (OrderID, ItemID),
	CONSTRAINT FK__OrderItems_OrderID__Orders_OrderID
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
	CONSTRAINT FK__OrderItems_ItemID__Items_ItemID
	FOREIGN KEY (ItemID)
	REFERENCES Items(ItemID)
