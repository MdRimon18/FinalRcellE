 CREATE PROCEDURE UpdateProduct
    @Id INT,
    @Name NVARCHAR(255),
    @Price DECIMAL(18, 2)
AS
BEGIN
    UPDATE Products
    SET Name = @Name, Price = @Price
    WHERE Id = @Id;
END;
