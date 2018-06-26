USE Geography

SELECT COUNT(CountryCode) AS [CountryCode]
FROM Countries
WHERE CountryCode NOT IN
(
	SELECT c.CountryCode
	FROM Countries AS c
	JOIN MountainsCountries AS mc
	ON mc.CountryCode = c.CountryCode
)
