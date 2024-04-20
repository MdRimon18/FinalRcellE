
 create PROCEDURE [dbo].[Status_Setting_Get_SP](
 @StatusSettingId bigint=null,
 @StatusSettingKey nvarchar(40)=null,
 @StatusSettingName nvarchar(100),
 @PageName nvarchar(100),
 @Position int=NULL,
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

      SELECT a.[StatusSettingId]
      ,a.[StatusSettingKey]
      ,a.[BranchId]
      ,a.[StatusSettingName]
      ,a.[PageName]
      ,a.[Position]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[StatusSettings]  a
	  WHERE  (@StatusSettingId IS NULL OR a.StatusSettingId = @StatusSettingId) and
	         (@StatusSettingKey IS NULL OR a.StatusSettingKey = @StatusSettingKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@StatusSettingName IS NULL OR a.StatusSettingName = @StatusSettingName)and
			  (@PageName IS NULL OR a.PageName = @PageName) and
			    (@Position IS NULL OR a.Position = @Position)
			  
			 and a.Status='Active'
      ORDER  BY a.StatusSettingId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [stt].[StatusSettings]
 
