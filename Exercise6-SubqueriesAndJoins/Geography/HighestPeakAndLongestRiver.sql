WITH CTE_PeaksByCountry AS
(
SELECT
	c.CountryName,
	p.Elevation
FROM Countries AS c
JOIN MountainsCountries AS mc
ON mc.CountryCode = c.CountryCode
JOIN Peaks AS p
ON p.MountainId = mc.MountainId
)
,

CTE_MaxPeakElevationByCountry AS
(
SELECT
	CountryName,
	MAX(Elevation) AS [HighestPeakElevation]
FROM CTE_PeaksByCountry
GROUP BY CountryName
)
,

CTE_RiversByCountry AS
(
SELECT
	c.CountryName,
	r.[Length] AS [RiverLength]
FROM Countries AS c
JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
JOIN Rivers AS r
ON r.Id = cr.RiverId
)
,

CTE_MaxRiverLengthByCountry AS
(
SELECT
	CountryName,
	MAX(RiverLength) AS [LongestRiverLength]
FROM CTE_RiversByCountry
GROUP BY CountryName
)

SELECT TOP (5)
	c.CountryName,
	mpebc.HighestPeakElevation,
	mrlbc.LongestRiverLength
FROM Countries AS c
LEFT OUTER JOIN CTE_MaxPeakElevationByCountry AS mpebc
ON mpebc.CountryName = c.CountryName
LEFT OUTER JOIN CTE_MaxRiverLengthByCountry AS mrlbc
ON mrlbc.CountryName = c.CountryName
ORDER BY
	mpebc.HighestPeakElevation DESC,
	mrlbc.LongestRiverLength DESC,
	c.CountryName
