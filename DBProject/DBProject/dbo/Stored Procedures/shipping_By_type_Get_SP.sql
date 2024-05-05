

 create PROCEDURE [dbo].[shipping_By_type_Get_SP](
 @ShippingById bigint=null,
 @ShippingByKey nvarchar(40)=null,
 @ShippingByName nvarchar(100)=null,
 @LanguageId Int,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[ShippingById]
      ,a.[ShippingByKey]
      ,a.[LanguageId]
      ,a.[ShippingByName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[ShippingBy] a
	  WHERE  (@ShippingById IS NULL OR a.ShippingById = @ShippingById) and
	         (@ShippingByKey IS NULL OR a.ShippingByKey = @ShippingByKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@ShippingByName IS NULL OR a.ShippingByName = @ShippingByName)  
			 and a.Status='Active'
      ORDER  BY a.ShippingById Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [invnt].[Units]