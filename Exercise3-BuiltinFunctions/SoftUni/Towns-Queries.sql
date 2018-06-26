USE SoftUni

SELECT [Name]
FROM Towns
WHERE LEN([Name]) IN (5, 6)
ORDER BY [Name]

SELECT TownID, [Name]
FROM Towns
WHERE SUBSTRING([Name], 1, 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

SELECT TownID, [Name]
FROM Towns
WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name]
