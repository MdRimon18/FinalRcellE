
 create PROCEDURE [dbo].[Language_Get_SP](
 @LanguageId int=null,
 @LanguageKey nvarchar(40)=null,
 @LanguageName nvarchar(100)=null,
 @BranchId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[LanguageId]
      ,a.[LanguageKey]
      
      ,a.[LanguageName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[Languages] a
	  WHERE  (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
	         (@LanguageKey IS NULL OR a.LanguageKey = @LanguageKey) and
			
		     (@LanguageName IS NULL OR a.LanguageName = @LanguageName)  
			 and a.Status='Active'
      ORDER  BY a.LanguageId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [stt].[Units]
 
