 CREATE PROCEDURE [dbo].[GetProduct]
    @Id INT
AS
BEGIN
    SELECT * FROM Products WHERE Id = @Id;
END;
