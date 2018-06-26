USE WMS
GO

CREATE FUNCTION dbo.udf_GetCost (@JobId INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
	RETURN
	(
		SELECT ISNULL(SUM(p.Price), 0)
		FROM Jobs AS j
		LEFT JOIN Orders AS o
		ON o.JobId = j.JobId
		LEFT JOIN OrderParts AS op
		ON op.OrderId = o.OrderId
		LEFT JOIN Parts AS p
		ON p.PartId = op.PartId
		WHERE j.JobId = @JobId
		GROUP BY j.JobId
	)
END
GO

SELECT dbo.udf_GetCost(1)
GO

SELECT dbo.udf_GetCost(2)
GO

SELECT dbo.udf_GetCost(777)
GO
