

 CREATE PROCEDURE [dbo].[Status_Setting_Get_SP](
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
      SET TRANSACTION isolation level READ uncommitted;

      
  WITH CTE AS  ( SELECT a.[StatusSettingId]
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
	  ,ROW_NUMBER() OVER (ORDER BY a.StatusSettingId ASC) AS RowNum 
      FROM   [stt].[StatusSettings]  a
	  WHERE  (@StatusSettingId IS NULL OR a.StatusSettingId = @StatusSettingId) and
	         (@StatusSettingKey IS NULL OR a.StatusSettingKey = @StatusSettingKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@StatusSettingName IS NULL OR a.StatusSettingName = @StatusSettingName)and
			  (@PageName IS NULL OR a.PageName = @PageName) and
			    (@StatusSettingName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.StatusSettingName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@StatusSettingName, ' ', ''))))  + '%')
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
        a.StatusSettingId DESC;
  END 
  
 -- select * from  [stt].[StatusSettings]
 
