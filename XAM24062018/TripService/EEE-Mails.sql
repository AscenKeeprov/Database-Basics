USE TripService

SELECT
	a.FirstName,
	a.LastName,
	FORMAT(a.BirthDate, 'MM-dd-yyyy', 'en-US') AS [BirthDate],
	c.[Name] AS [Hometown],
	a.Email
FROM Accounts AS a
JOIN Cities AS c
ON c.Id = a.CityId
WHERE LEFT(Email, 1) = 'e'
ORDER BY Hometown DESC
