
CREATE procedure [dbo].[sp_order_update](
  @orderId BIGINT=0, 
  @orderKey uniqueidentifier=null,
  @productName NVARCHAR(100), 
  @categoryId BIGINT = NULL, 
  @orderDate DATETIME = NULL, 
  @isProductRecieve BIT = NULL,
  @entryDateTime datetime=null,
  @entryBy bigint=null,
  @status varchar(10)=null,
  @success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		  a.ProductName = @productName, 
		  a.CategoryId = @categoryId, 
		  a.OrderDate = @orderDate, 
		  a.IsProductRecieve = @isProductRecieve,
		  a.Status=@status
		 FROM 
		  [dbo].[Order] a WITH(ROWLOCK) 
		  WHERE 
		  a.OrderId = @orderId 
		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

