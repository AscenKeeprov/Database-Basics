USE Diablo

SELECT
	Username,
	REPLACE(
		Email,
		SUBSTRING(Email, 1,
		CHARINDEX('@', Email)), '')
	AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username

SELECT Username, IpAddress
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username
