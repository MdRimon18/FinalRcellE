 CREATE PROCEDURE [dbo].[DeleteProduct]
    @Id INT
AS
BEGIN
    DELETE FROM Products
    WHERE Id = @Id;
END;
