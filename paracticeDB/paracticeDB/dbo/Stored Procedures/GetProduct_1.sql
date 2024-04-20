 CREATE PROCEDURE GetProduct
    @Id INT
AS
BEGIN
    SELECT * FROM Products WHERE Id = @Id;
END;
