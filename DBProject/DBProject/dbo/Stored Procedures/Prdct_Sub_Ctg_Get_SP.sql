  CREATE PROCEDURE [dbo].[Prdct_Sub_Ctg_Get_SP](
 @ProdSubCtgId bigint=null,
 @ProdSubCtgKey nvarchar(40)=null,
 @BranchId bigint,
 @ProdCtgId bigint,
 @ProdSubCtgName nvarchar(100), 
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[ProdSubCtgId]
				  ,a.[ProdSubCtgKey]
				  ,a.[BranchId]
				  ,a.[ProdCtgId]
				  ,a.[ProdSubCtgName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate] 
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.ProdSubCtgId ASC) AS RowNum 
      FROM  [invnt].[ProductSubCategories] a
	  WHERE  (@ProdSubCtgId IS NULL OR a.ProdSubCtgId = @ProdSubCtgId) and
	         (@ProdSubCtgKey IS NULL OR a.ProdSubCtgKey = @ProdSubCtgKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
			 (@ProdCtgId IS NULL OR a.ProdCtgId = @ProdCtgId) and
		     (@ProdSubCtgName IS NULL OR
			   
			 LOWER(LTRIM(RTRIM(REPLACE(a.ProdSubCtgName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@ProdSubCtgName, ' ', ''))))  + '%')
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
        a.ProdSubCtgId DESC;
  END