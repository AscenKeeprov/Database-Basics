WITH CTE_CurrUseByCont (ContinentCode, CurrencyCode, CurrencyUsage) AS
(
SELECT
	ContinentCode,
	CurrencyCode,
	COUNT(CurrencyCode) AS [CurrencyUsage]
FROM Countries
GROUP BY ContinentCode, CurrencyCode
HAVING COUNT(CurrencyCode) > 1
)
,

CTE_MaxCurrUseByCont (ContinentCode, MaxCurrencyUsage) AS
(
SELECT
	ContinentCode,
	MAX(CurrencyUsage) AS [MaxCurrencyUsage]
FROM CTE_CurrUseByCont
GROUP BY ContinentCode
)

SELECT
	cubc.ContinentCode,
	cubc.CurrencyCode,
	mcubc.MaxCurrencyUsage AS [CurrencyUsage]
FROM CTE_CurrUseByCont AS cubc
JOIN CTE_MaxCurrUseByCont AS mcubc
ON mcubc.ContinentCode = cubc.ContinentCode
AND mcubc.MaxCurrencyUsage = cubc.CurrencyUsage
ORDER BY cubc.ContinentCode
