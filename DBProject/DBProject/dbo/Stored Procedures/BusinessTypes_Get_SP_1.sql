

 Create PROCEDURE [dbo].[BusinessTypes_Get_SP](
 @BusinessTypeId bigint=null,
 @BusinessTypeKey nvarchar(40)=null,
 @BusinessTypeName nvarchar(100)=null,
 @LanguageId Int=null,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[BusinessTypeId]
				  ,a.[BusinessTypeKey]
				  ,a.[LanguageId]
				  ,a.[BusinessTypeName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.BusinessTypeId ASC) AS RowNum 
      FROM   [stt].[BusinessTypes] a
	  WHERE  (@BusinessTypeId IS NULL OR a.BusinessTypeId= @BusinessTypeId) and
	         (@BusinessTypeKey IS NULL OR a.BusinessTypeKey= @BusinessTypeKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@BusinessTypeName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.BusinessTypeName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@BusinessTypeName, ' ', ''))))  + '%')
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
        a.BusinessTypeId DESC;
  END