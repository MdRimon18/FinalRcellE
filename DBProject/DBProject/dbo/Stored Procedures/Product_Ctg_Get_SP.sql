
 CREATE PROCEDURE [dbo].[Product_Ctg_Get_SP](
 @ProdCtgId bigint=null,
 @ProdCtgKey nvarchar(40)=null,
 @ProdCtgName nvarchar(100)=null,
 @BranchId bigint=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;

     
    with CTE as (  SELECT a.[ProdCtgId]
      ,a.[ProdCtgKey]
      ,a.[BranchId]
      ,a.[ProdCtgName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	   ,ROW_NUMBER() OVER (ORDER BY a.ProdCtgId ASC) AS RowNum
      FROM   [invnt].[ProductCategories] a
	  WHERE  (@ProdCtgId IS NULL OR a.ProdCtgId = @ProdCtgId) and
	         (@ProdCtgKey IS NULL OR a.ProdCtgKey = @ProdCtgKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@ProdCtgName IS NULL OR

			 LOWER(LTRIM(RTRIM(REPLACE(a.ProdCtgName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@ProdCtgName, ' ', ''))))  + '%')
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
        a.ProdCtgId DESC;
  END 
  
 -- select * from  [invnt].[ProductCategories]