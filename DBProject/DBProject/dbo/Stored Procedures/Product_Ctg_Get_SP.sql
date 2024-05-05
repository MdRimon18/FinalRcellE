
 create PROCEDURE [dbo].[Product_Ctg_Get_SP](
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
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[ProdCtgId]
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
	  
      FROM   [invnt].[ProductCategories] a
	  WHERE  (@ProdCtgId IS NULL OR a.ProdCtgId = @ProdCtgId) and
	         (@ProdCtgKey IS NULL OR a.ProdCtgKey = @ProdCtgKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@ProdCtgName IS NULL OR a.ProdCtgName = @ProdCtgName)  
			 and a.Status='Active'
      ORDER  BY a.ProdCtgId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [invnt].[ProductCategories]