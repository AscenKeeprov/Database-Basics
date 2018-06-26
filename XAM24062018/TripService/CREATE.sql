USE TripService

CREATE TABLE Cities
(
	Id INT IDENTITY
		CONSTRAINT PK__City_Id
		PRIMARY KEY (Id),
	[Name] NVARCHAR(20) NOT NULL,
	CountryCode CHAR(2) NOT NULL
)

CREATE TABLE Hotels
(
	Id INT IDENTITY
		CONSTRAINT PK__Hotel_Id
		PRIMARY KEY (Id),
	[Name] NVARCHAR(30) NOT NULL,
	CityId INT NOT NULL
		CONSTRAINT FK__Hotels_CityId__Cities_Id
		FOREIGN KEY (CityId) REFERENCES Cities(Id),
	EmployeeCount INT NOT NULL,
	BaseRate DECIMAL(18,2)
)

CREATE TABLE Rooms
(
	Id INT IDENTITY
		CONSTRAINT PK__Room_Id
		PRIMARY KEY (Id),
	Price DECIMAL(18,2) NOT NULL,
	[Type] NVARCHAR(20) NOT NULL,
	Beds INT NOT NULL,
	HotelId INT NOT NULL
		CONSTRAINT FK__Rooms_HotelId__Hotels_Id
		FOREIGN KEY (HotelId) REFERENCES Hotels(Id)
)

CREATE TABLE Trips
(
	Id INT IDENTITY
		CONSTRAINT PK__Trip_Id
		PRIMARY KEY (Id),
	RoomId INT NOT NULL
		CONSTRAINT FK__Trips_RoomId__Rooms_Id
		FOREIGN KEY (RoomId) REFERENCES Rooms(Id),
	BookDate DATE NOT NULL,
	ArrivalDate DATE NOT NULL,
	ReturnDate DATE NOT NULL,
	CancelDate DATE,
	CONSTRAINT CK__Trip_BookDate__Valid
	CHECK (BookDate <= ArrivalDate),
	CONSTRAINT CK__Trip_ArrivalDate__Valid
	CHECK (ArrivalDate <= ReturnDate)
)

CREATE TABLE Accounts
(
	Id INT IDENTITY
		CONSTRAINT PK__Account_Id
		PRIMARY KEY (Id),
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(20),
	LastName NVARCHAR(50) NOT NULL,
	CityId INT NOT NULL
		CONSTRAINT FK__Accounts_CityId__Cities_Id
		FOREIGN KEY (CityId) REFERENCES Cities(Id),
	BirthDate DATE NOT NULL,
	Email VARCHAR(100) NOT NULL
		CONSTRAINT UQ__Account_Email
		UNIQUE (Email)
)

CREATE TABLE AccountsTrips
(
	AccountId INT NOT NULL
		CONSTRAINT FK__AccountsTrips_AccountId__Accounts_Id
		FOREIGN KEY (AccountId) REFERENCES Accounts(Id),
	TripId INT NOT NULL,
		CONSTRAINT FK__AccountsTrips_TripId__Trips_Id
		FOREIGN KEY (TripId) REFERENCES Trips(Id),
	Luggage INT NOT NULL
		CONSTRAINT CK__AccountTrip_Luggage__Valid
		CHECK (Luggage >= 0)
	CONSTRAINT PK__AccountsTrips__AccountId_TripId
	PRIMARY KEY (AccountId, TripId)
)
