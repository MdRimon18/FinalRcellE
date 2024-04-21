
 CREATE PROCEDURE [dbo].[Unit_Get_SP](
 @UnitId bigint=null,
 @UnitKey nvarchar(40)=null,
 @UnitName nvarchar(100)=null,
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

      SELECT a.[UnitId]
      ,a.[UnitKey]
      ,a.[BranchId]
      ,a.[UnitName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [invnt].[Units] a
	  WHERE  (@UnitId IS NULL OR a.UnitId = @UnitId) and
	         (@UnitKey IS NULL OR a.UnitKey = @UnitKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@UnitName IS NULL OR a.UnitName = @UnitName)  
			 and a.Status='Active'
      ORDER  BY a.UnitId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [invnt].[Units]
 
