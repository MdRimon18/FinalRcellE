 CREATE PROCEDURE DeleteProduct
    @Id INT
AS
BEGIN
    DELETE FROM Products
    WHERE Id = @Id;
END;
