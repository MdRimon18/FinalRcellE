Create PROCEDURE [dbo].[Language_Get_SP](
 @LanguageId int=null,
 @LanguageKey nvarchar(40)=null,
 @LanguageName nvarchar(100)=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;


     WITH CTE AS  (SELECT a.[LanguageId]
      ,a.[LanguageKey]     
      ,a.[LanguageName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
	  ,ROW_NUMBER() OVER (ORDER BY a.LanguageId ASC) AS RowNum 

      FROM   [stt].[Languages] a
	  WHERE  (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
	         (@LanguageKey IS NULL OR a.LanguageKey = @LanguageKey) and
			
		     (@LanguageName IS NULL OR
			  LOWER(LTRIM(RTRIM(REPLACE(a.LanguageName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@LanguageName, ' ', ''))))  + '%')
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
        a.LanguageId DESC;

		END
 
