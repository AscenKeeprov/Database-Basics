USE Geography

SELECT CountryName, IsoCode
FROM Countries
WHERE UPPER(CountryName) LIKE '%A%A%A%'
ORDER BY IsoCode

SELECT
	P.PeakName,
	R.RiverName,
	LOWER(
		CONCAT(
			SUBSTRING(P.PeakName, 1, LEN(P.PeakName) - 1),
		 R.RiverName)) AS [Mix]
FROM Peaks AS P, Rivers AS R
WHERE RIGHT(P.PeakName, 1) = LEFT(R.RiverName, 1)
ORDER BY P.PeakName, R.RiverName
