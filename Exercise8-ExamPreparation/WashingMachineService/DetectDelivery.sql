USE WMS
GO

CREATE TRIGGER TR__Orders_Delivered__UPDATE
ON Orders
FOR UPDATE
AS
BEGIN
	WITH CTE_PartsDelivered AS
	(
		SELECT op.PartId, op.Quantity
		FROM inserted AS i
		JOIN deleted AS d
		ON d.OrderId = i.OrderId
		AND i.Delivered > d.Delivered
		JOIN OrderParts AS op
		ON op.OrderId = d.OrderId
	)

	UPDATE Parts
	SET StockQty += pd.Quantity
	FROM Parts AS p
	JOIN CTE_PartsDelivered AS pd
	ON pd.PartId = p.PartId
END
GO
