
 CREATE PROCEDURE [dbo].[PrdcuctSize_GetSP](
 @ProductSizeId bigint=null,
 @ProductSizeKey nvarchar(40)=null,
 @LanguageId  bigint, 
 @ProductSizeName nvarchar(100), 
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[ProductSizeId]
				  ,a.[ProductSizeKey]
				  ,a.[LanguageId]				  
				  ,a.[ProductSizeName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate] 
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.ProductSizeId ASC) AS RowNum 
      FROM  [invnt].[ProductSizes] a
	  WHERE  (@ProductSizeId IS NULL OR a.ProductSizeId = @ProductSizeId) and
	         (@ProductSizeKey IS NULL OR a.ProductSizeKey = @ProductSizeKey) and
			 (@LanguageId  IS NULL OR a.LanguageId  = @LanguageId ) and
			
		     (@ProductSizeName IS NULL OR   
			 LOWER(LTRIM(RTRIM(REPLACE(a.ProductSizeName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@ProductSizeName, ' ', ''))))  + '%')
			 and a.Status='Active'
      )
      
		SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > ((@PageNumber - 1) * @PageSize) AND RowNum <= (@PageNumber * @PageSize)    
        ORDER BY 
        a.ProductSizeId DESC;
  END 
  
 -- select * from  [invnt].[ProductCategories]