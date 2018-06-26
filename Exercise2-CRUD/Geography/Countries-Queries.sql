USE Geography

SELECT TOP(30)
	CountryName,
	[Population]
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY [Population] DESC, CountryName

SELECT
	CountryName,
	CountryCode,
	Currency =
	CASE CurrencyCode
		WHEN 'EUR' THEN 'Euro'
		ELSE 'Not Euro'  
	END
FROM Countries
ORDER BY CountryName
