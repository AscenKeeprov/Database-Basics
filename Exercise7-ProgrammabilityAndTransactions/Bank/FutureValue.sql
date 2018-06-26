USE Bank
GO

CREATE FUNCTION dbo.ufn_CalculateFutureValue
(
	@sum DECIMAL(17,4),
	@annualInterest FLOAT,
	@years INT
)
RETURNS DECIMAL(17,4) AS
BEGIN
	RETURN @sum * POWER((1 + @annualInterest), @years)
END
GO

PRINT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO
