

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
      SET TRANSACTION isolation level READ uncommitted;

  WITH CTE AS (
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

	  ,ROW_NUMBER() OVER (ORDER BY a.UnitId ASC) AS RowNum 
	  
      FROM   [invnt].[Units] a
	  WHERE  (@UnitId IS NULL OR a.UnitId = @UnitId) and
	         (@UnitKey IS NULL OR a.UnitKey = @UnitKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@UnitName IS NULL OR 
			  LOWER(LTRIM(RTRIM(REPLACE(a.UnitName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@UnitName, ' ', ''))))  + '%')
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
        a.UnitId DESC;
  END 
 -- select * from  [invnt].[Units]
 
