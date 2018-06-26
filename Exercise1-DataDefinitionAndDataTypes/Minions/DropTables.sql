DECLARE @Statement NVARCHAR(MAX)
DECLARE @TableName VARCHAR(MAX)

DECLARE UserTables CURSOR FOR
	SELECT name
	FROM   sys.tables
	WHERE  type = 'U'
	AND SCHEMA_ID = 1

OPEN UserTables

FETCH NEXT FROM UserTables INTO @TableName

WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Statement = 'DROP TABLE ' + @TableName
		EXECUTE sp_executesql @Statement
		FETCH NEXT FROM UserTables INTO @TableName
	END

CLOSE UserTables
DEALLOCATE UserTables
