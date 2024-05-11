

 Create PROCEDURE [dbo].[shipping_By_type_Get_SP](
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
      SET TRANSACTION isolation level READ uncommitted;


  WITH CTE AS  (  SELECT a.[ShippingById]
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
	  , ROW_NUMBER() OVER (ORDER BY a.ShippingById ASC) AS ROWNUM
	  
      FROM   [stt].[ShippingBy] a
	  WHERE  (@ShippingById IS NULL OR a.ShippingById = @ShippingById) and
	         (@ShippingByKey IS NULL OR a.ShippingByKey = @ShippingByKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@ShippingByName IS NULL OR 
			  LOWER(LTRIM(RTRIM(REPLACE(a.ShippingByName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@ShippingByName, ' ', ''))))  + '%')
			 and a.Status='Active'
      )
			 
     SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > ((@page_number - 1) * @page_size) AND RowNum <= (@page_number * @page_size)     
        ORDER BY 
        a.ShippingById DESC;
  END 
  
 -- select * from  [stt].[ShippingBy]