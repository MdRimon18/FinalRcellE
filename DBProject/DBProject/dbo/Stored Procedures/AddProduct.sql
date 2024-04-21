CREATE procedure [dbo].[AddProduct](
@Id  int OUTPUT,
@Name  nvarchar(255) ,
@Price  decimal(18,2) ) AS 
BEGIN         SET NOCOUNT ON        
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
INSERT INTO  dbo.Products
VALUES (@Name, @Price ) 
SET  @Id = SCOPE_IDENTITY();   
SELECT @Id  id 
END
