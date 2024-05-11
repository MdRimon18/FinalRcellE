
 CREATE PROCEDURE [dbo].[Color_Get_SP](
 @ColorId bigint=null,
 @ColorKey nvarchar(40)=null,
 @LanguageId bigint,
 @ColorIdName nvarchar(100), 
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[ColorId]
				  ,a.[ColorKey]
				  ,a.[LanguageId]			 
				  ,a.[ColorIdName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate] 
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.ColorId ASC) AS RowNum 
      FROM  [stt].[Colors] a
	  WHERE  (@ColorId IS NULL OR a.ColorId = @ColorId) and
	         (@ColorKey IS NULL OR a.ColorKey = @ColorKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
			
		     (@ColorIdName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.ColorIdName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@ColorIdName, ' ', ''))))  + '%')
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
        a.ColorId DESC;
  END