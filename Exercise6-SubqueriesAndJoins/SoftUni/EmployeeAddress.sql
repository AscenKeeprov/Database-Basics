USE SoftUni

SELECT TOP (5)
	e.EmployeeID AS EmployeeId,
	e.JobTitle,
	e.AddressID AS AddressId,
	a.AddressText
FROM Employees AS e
JOIN Addresses AS a
ON a.AddressID = e.AddressID
ORDER BY AddressID
