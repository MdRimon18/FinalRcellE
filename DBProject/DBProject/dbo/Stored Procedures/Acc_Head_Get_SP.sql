

 CREATE PROCEDURE [dbo].[Acc_Head_Get_SP](
 @AccHeadId bigint=null,
 @AccHeadKey nvarchar(40)=null,
 @AccHeadName nvarchar(100)=null,

 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[AccHeadId]
      ,a.[AccHeadKey]
      ,a.[AccHeadName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [Acc].[AccHeads] a
	  WHERE  (@AccHeadId IS NULL OR a.AccHeadId = @AccHeadId) and
	         (@AccHeadKey IS NULL OR a.AccHeadKey= @AccHeadKey) and
			
		     (@AccHeadName  IS NULL OR a.AccHeadName= @AccHeadName )  
			 and a.Status='Active'
      ORDER  BY a.AccHeadId  Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [invnt].[Units]