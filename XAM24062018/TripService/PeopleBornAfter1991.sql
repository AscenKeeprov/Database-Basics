USE TripService

SELECT
	CONCAT(
		FirstName, ' ',
		CASE
			WHEN MiddleName IS NULL THEN ''
			ELSE MiddleName + ' '
		END,
		LastName) AS [Full Name],
	YEAR(BirthDate) AS [BirthYear]
FROM Accounts
WHERE YEAR(BirthDate) > 1991
ORDER BY [BirthYear] DESC, FirstName
