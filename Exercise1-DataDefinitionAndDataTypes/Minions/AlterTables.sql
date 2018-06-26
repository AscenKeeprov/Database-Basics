ALTER TABLE Minions
ADD TownId INT NOT NULL
	CONSTRAINT FK__Minions_TownId__Towns_Id
	FOREIGN KEY (TownId) REFERENCES Towns (Id)
GO

BEGIN /*Delete primary key for table "Users"*/
	DECLARE @TableId INT =
	(
	SELECT object_id FROM sys.objects
	WHERE type = 'U'
	AND name = 'Users'
	)

	DECLARE @PrimaryKeyName sysname =
	(
	SELECT name FROM sys.key_constraints
	WHERE type = 'PK'
	AND parent_object_id = @TableId
	)

	IF @PrimaryKeyName IS NOT NULL
	BEGIN
		DECLARE @Statement NVARCHAR(MAX) = 'ALTER TABLE Users DROP CONSTRAINT ' + @PrimaryKeyName
		PRINT @Statement
		EXEC sp_executesql @Statement;
	END
END

ALTER TABLE Users
ADD CONSTRAINT PK__Id_Username PRIMARY KEY (Id, Username)

ALTER TABLE Users
ADD CONSTRAINT CK__Password__Min_5 CHECK ([Password]<=5)

ALTER TABLE Users
ADD CONSTRAINT DF__LastLoginTime__CurrentTime
DEFAULT CONVERT(DATETIME2, GETDATE(),20) FOR LastLoginTime

ALTER TABLE Users
DROP CONSTRAINT PK__Id_Username

ALTER TABLE Users
ADD CONSTRAINT PK__Id PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CK__Username__Min_3
CHECK (LEN(Username) >= 3)
