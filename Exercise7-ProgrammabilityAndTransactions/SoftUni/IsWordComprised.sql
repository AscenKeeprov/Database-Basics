USE SoftUni
GO

CREATE FUNCTION dbo.ufn_IsWordComprised
 (@letters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @isContained BIT = 1
	DECLARE @index INT = 1
	DECLARE @wordLength INT = LEN(@word)
	WHILE (@index <= @wordLength)
	BEGIN
		IF CHARINDEX(SUBSTRING(@word, @index, 1), @letters) = 0
		BEGIN
			SET @isContained = 0
			BREAK
		END
		SET @index = @index + 1
	END
	RETURN @isContained
END
GO

SELECT
	'oistmiahf' AS [SetOfLetters],
	'Sofia' AS [Word],
	dbo.ufn_IsWordComprised('oistmiahf','Sofia') AS [Result]
GO

SELECT
	'oistmiah' AS [SetOfLetters],
	'Sofia' AS [Word],
	dbo.ufn_IsWordComprised('oistmiah','Sofia') AS [Result]
GO
