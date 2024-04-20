
CREATE PROCEDURE [dbo].[sp_insert_order](
  @orderId BIGINT OUTPUT, 
  @orderKey uniqueidentifier=null,
  @productName NVARCHAR(100), 
  @categoryId BIGINT = NULL, 
  @orderDate DATETIME = NULL, 
  @isProductRecieve BIT = NULL,
  @EntryDateTime datetime,
  @EntryBy bigint,
  @Status varchar(10)=null 
) AS BEGIN 
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      INSERT INTO  [dbo].[Order]
      VALUES      (
	                NEWID(),  
                    @productName,
                    @categoryId,
                    @orderDate,
                    @isProductRecieve,
					@EntryDateTime,
					@EntryBy,
					'Active')

      SET @orderId = Scope_identity();
      SELECT @orderId orderId
  END 
