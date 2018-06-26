USE WMS
GO

CREATE PROCEDURE dbo.usp_PlaceOrder
 (@jobId INT, @partSerialNumber VARCHAR(50), @partQuantity INT)
AS
BEGIN TRANSACTION
	DECLARE @partId INT = 
	(
		SELECT PartId
		FROM Parts
		WHERE SerialNumber = @partSerialNumber
	)

	DECLARE @orderId INT = 
	(
		SELECT TOP(1) OrderId
		FROM Orders
		WHERE JobId = @jobId
		AND IssueDate IS NULL
		ORDER BY OrderId
	)

	IF (@partQuantity <= 0)
	BEGIN
		;THROW 50012, 'Part quantity must be more than zero!', 1
		ROLLBACK
		RETURN
	END

	IF (@JobId IN (SELECT JobId FROM Jobs WHERE [Status] = 'Finished'))
	BEGIN
		;THROW 50011, 'This job is not active!', 1
		ROLLBACK
		RETURN
	END

	IF (@JobId NOT IN (SELECT JobId FROM Jobs))
	BEGIN
		;THROW 50013, 'Job not found!', 1
		ROLLBACK
		RETURN
	END

	IF (@partId IS NULL)
	BEGIN
		;THROW 50014, 'Part not found!', 1
		ROLLBACK
		RETURN
	END

	IF (@orderId IS NULL)
	BEGIN
		INSERT INTO Orders (JobId, IssueDate)
		VALUES (@jobId, NULL)

		SET @orderId =
		(
			SELECT TOP(1) OrderId
			FROM Orders
			WHERE JobId = @jobId
			AND IssueDate IS NULL
			ORDER BY OrderId DESC
		)

		INSERT INTO OrderParts (OrderId, PartId, Quantity)
		VALUES (@orderId, @partId, @partQuantity)
	END
	ELSE
	BEGIN
		IF (EXISTS (
			SELECT *
			FROM OrderParts
			WHERE OrderId = @orderId
			AND PartId = @partId))
		BEGIN
			UPDATE OrderParts
			SET Quantity += @partQuantity
			WHERE OrderId = @orderId
			AND PartId = @partId
		END
		ELSE
		BEGIN
			INSERT INTO OrderParts (OrderId, PartId, Quantity)
			VALUES (@orderId, @partId, @partQuantity)
		END
	END
COMMIT
GO

BEGIN	--Test procedure
	BEGIN TRY
	  EXECUTE dbo.usp_PlaceOrder
		--@JobId = 45,
		@JobId = 1,	/*Inactive job test*/
		--@JobId = 777,	/*Inexistent job test*/
		@partSerialNumber = '285753A',
		--@partSerialNumber = 'S3rNum',	/*Inexistent part test*/
		--@partQuantity = 2
		@partQuantity = -2	/*Invalid quantity test*/
	END TRY

	BEGIN CATCH
	  PRINT ERROR_MESSAGE()
	END CATCH
END
GO
