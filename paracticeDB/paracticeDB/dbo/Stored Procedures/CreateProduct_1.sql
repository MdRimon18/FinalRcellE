 CREATE PROCEDURE CreateProduct
    @Name NVARCHAR(255),
    @Price DECIMAL(18, 2)
AS
BEGIN
    INSERT INTO Products (Name, Price)
    VALUES (@Name, @Price);

    SELECT SCOPE_IDENTITY() AS Id; -- Return the newly created product's ID
END;
