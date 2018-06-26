WITH CTE_PeaksByCountry AS
(
SELECT
	c.CountryName,
	p.PeakName,
	p.Elevation,
	m.MountainRange
FROM Countries AS c
JOIN MountainsCountries AS mc
ON mc.CountryCode = c.CountryCode
JOIN Peaks AS p
ON p.MountainId = mc.MountainId
JOIN Mountains As m
ON m.Id = p.MountainId
)
,

CTE_MaxPeakElevationByCountry AS
(
SELECT
	CountryName,
	MAX(Elevation) AS [MaxElevation]
FROM CTE_PeaksByCountry
GROUP BY CountryName
)
,

CTE_HighestPeakByCountry AS
(
SELECT
	pbc.CountryName,
	pbc.PeakName,
	mpebc.MaxElevation,
	pbc.MountainRange
FROM CTE_PeaksByCountry AS pbc
JOIN CTE_MaxPeakElevationByCountry mpebc
ON mpebc.CountryName = pbc.CountryName
AND mpebc.MaxElevation = pbc.Elevation
)

SELECT TOP(5)
	c.CountryName AS [Country],
	CASE
		WHEN hpbc.PeakName IS NULL THEN  '(no highest peak)'
		ELSE hpbc.PeakName
	END AS [Highest Peak Name],
	CASE
		WHEN hpbc.MaxElevation IS NULL THEN 0
		ELSE hpbc.MaxElevation
	END AS [Highest Peak Elevation],
	CASE
		WHEN hpbc.MountainRange IS NULL THEN '(no mountain)'
		ELSE hpbc.MountainRange
	END AS [Mountain]
FROM Countries AS c
LEFT OUTER JOIN CTE_HighestPeakByCountry AS hpbc
ON hpbc.CountryName = c.CountryName
ORDER BY Country, [Highest Peak Name]
