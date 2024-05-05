
Create PROCEDURE [dbo].[BusinessTypes_Get_SP](
 @BusinessTypeId bigint=null,
 @BusinessTypeKey nvarchar(40)=null,
 @BusinessTypeName nvarchar(100)=null,
 @LanguageId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[BusinessTypeId]
      ,a.[BusinessTypeKey]
      ,a.[BusinessTypeName]
      ,a.[LanguageId]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[BusinessTypes] a
	  WHERE  (@BusinessTypeId IS NULL OR a.BusinessTypeId = @BusinessTypeId) and
	         (@BusinessTypeKey IS NULL OR a.BusinessTypeKey = @BusinessTypeKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@BusinessTypeName IS NULL OR a.BusinessTypeName = @BusinessTypeName)  
			 and a.Status='Active'
      ORDER  BY a.BusinessTypeId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 --select * from  [invnt].[BusinessTypes]