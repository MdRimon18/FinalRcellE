

 CREATE PROCEDURE [dbo].[CompanyBranch_Get_SP](
 @BranchId bigint=null,
 @BranchKey nvarchar(40)=null,
 @CompanyId bigint,
 @SearchValue nvarchar(100)=null,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT  [BranchId]
						  ,[BranchKey]
						  ,[CompanyId]
						  ,[BranchName]
						  ,[MobileNo]
						  ,[Email]
						  ,[StateName]
						  ,[Address]
						  ,[BrnchManagerName]
						  ,[ManagerMobile]
						  ,[BranchImgLink]
						  ,[EntryDateTime]
						  ,[EntryBy]
						  ,[LastModifyDate]
						  ,[LastModifyBy]
						  ,[DeletedDate]
						  ,[DeletedBy]
						  ,[Status]
				  
				  ,ROW_NUMBER() OVER (ORDER BY a.BranchId ASC) AS RowNum 
      FROM   [stt].[CompanyBranch] a 
	  WHERE  (@BranchId IS NULL OR a.BranchId = @BranchId) and
	         (@BranchKey IS NULL OR a.BranchKey = @BranchKey) and
			 (@CompanyId IS NULL OR a.CompanyId = @CompanyId) and
			
			
		     (@SearchValue IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.BranchName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SearchValue, ' ', ''))))  + '%'
			 or
			 LOWER(LTRIM(RTRIM(REPLACE(a.MobileNo, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SearchValue, ' ', ''))))  + '%'
			 or
			 LOWER(LTRIM(RTRIM(REPLACE(a.Email, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SearchValue, ' ', ''))))  + '%')
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
        a.BranchId DESC;
  END