 
 CREATE PROCEDURE [dbo].[sp_order_getAll](
 @OrderId bigint=null,
 @ProductName nvarchar(100)=null,
 @page INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page - 1) * @page_size;

      SELECT a.OrderId,
	  a.OrderKey,
             a.ProductName,
             a.CategoryId,
             a.OrderDate,
             a.IsProductRecieve,
			 a.EntryDateTime,
			 a.EntryBy,
			 a.Status

      FROM   [dbo].[order] a
	  WHERE  (@orderId IS NULL OR a.orderId = @OrderId) and
	         (@ProductName IS NULL OR a.ProductName = @ProductName)
			 and a.Status='Active'
      ORDER  BY a.orderid Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [dbo].[Order]
 