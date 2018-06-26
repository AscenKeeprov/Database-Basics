CREATE TABLE Directors
(
	Id INT IDENTITY
		CONSTRAINT PK__Director_Id
		PRIMARY KEY (Id),
	DirectorName NVARCHAR(200) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Genres
(
	Id INT IDENTITY
		CONSTRAINT PK__Genre_Id
		PRIMARY KEY (Id),
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Categories
(
	Id INT IDENTITY
		CONSTRAINT PK__Category_Id
		PRIMARY KEY (Id),
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

CREATE TABLE Movies
(
	Id INT IDENTITY
		CONSTRAINT PK__Movie_Id
		PRIMARY KEY (Id),
	Title NVARCHAR(100) NOT NULL
		CONSTRAINT UQ__Title
		UNIQUE (Title),
	DirectorId INT NOT NULL
		CONSTRAINT FK__DirectorId
		FOREIGN KEY (DirectorId)
		REFERENCES Directors(Id),
	CopyrightYear SMALLINT NOT NULL
		CONSTRAINT CK__CopyrightYear__Valid
		CHECK (CopyrightYear >= 1900),
	[Length] TIME(0) NOT NULL
		CONSTRAINT CK__Length__Valid
		CHECK ([Length] > '00:00:00'),
	GenreId INT NOT NULL
		CONSTRAINT FK__GenreId
		FOREIGN KEY (GenreId)
		REFERENCES Genres(Id),
	CategoryId INT NOT NULL
		CONSTRAINT FK__CategoryId
		FOREIGN KEY (CategoryId)
		REFERENCES Categories(Id),
	Rating DECIMAL(2,1)
		CONSTRAINT CK__Rating__Valid
		CHECK (Rating >= 0 AND Rating <= 10)
		CONSTRAINT DF__Rating__0
		DEFAULT 0,
	Notes NVARCHAR(MAX)
)
