USE Bank
GO

CREATE PROCEDURE dbo.usp_WithdrawMoney
 (@AccountId INT, @MoneyAmount DECIMAL(18,4))
 AS
 BEGIN
	--BEGIN TRANSACTION

	DECLARE @currentBalance MONEY = 
	(
		SELECT Balance
		FROM Accounts
		WHERE Id = @AccountId
	)

	IF @currentBalance >= @MoneyAmount
	BEGIN
		UPDATE Accounts
		SET Balance -= @MoneyAmount
		WHERE Id = @AccountId
	END
	--ELSE
	--BEGIN
	--	RAISERROR
	--	(
	--		'Error processing transaction. Please try again.',	--Message
	--		16,	--Severity
	--		1	--State.
	--	)
	--	ROLLBACK
	--	RETURN
	--END

	--COMMIT TRANSACTION
 END
 GO

EXECUTE usp_WithdrawMoney @AccountId = 1, @MoneyAmount = 120
GO

UPDATE Accounts
SET Balance += 120
WHERE Id = 1
GO
