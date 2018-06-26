USE Bank
GO

CREATE PROCEDURE dbo.usp_TransferMoney
 (@SenderId INT, @ReceiverId INT, @Amount DECIMAL(18,4))
AS
BEGIN
	BEGIN TRANSACTION

	IF (@Amount > 0)
	BEGIN TRY
		EXECUTE usp_WithdrawMoney @AccountId = @SenderId, @MoneyAmount = @Amount
		EXECUTE usp_DepositMoney @AccountId = @ReceiverId, @MoneyAmount = @Amount
	END TRY
	BEGIN CATCH
		ROLLBACK
		RETURN
	END CATCH

	COMMIT TRANSACTION
END
GO

--Judge-compatible solution:
--CREATE PROCEDURE dbo.usp_TransferMoney
-- (@SenderId INT, @ReceiverId INT, @Amount DECIMAL(18,4))
--AS
--BEGIN
--	DECLARE @senderBalance MONEY = 
--	(
--		SELECT Balance
--		FROM Accounts
--		WHERE Id = @SenderId
--	)

--	IF @senderBalance >= @Amount
--	BEGIN
--		UPDATE Accounts
--		SET Balance -= @Amount
--		WHERE Id = @SenderId
        
--  		UPDATE Accounts
--		SET Balance += @Amount
--		WHERE Id = @ReceiverId
--	END
--END

EXECUTE usp_TransferMoney @SenderId = 5, @ReceiverId = 1, @Amount = 5000
GO

EXECUTE usp_TransferMoney @SenderId = 1, @ReceiverId = 5, @Amount = 5000
GO
