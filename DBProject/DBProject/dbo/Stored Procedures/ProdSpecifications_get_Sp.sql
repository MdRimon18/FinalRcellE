
 Create PROCEDURE [dbo].[ProdSpecifications_get_Sp](
 @ProdSpcfctnId bigint=null,
 @ProdSpcfctnKey nvarchar(40)=null,
 @ProductId BIGINT,
 @SpecificationName NVARCHAR(150), 
 @SpecificationDtls nvarchar(max)=null,	
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[ProdSpcfctnId]
				  ,a.[ProdSpcfctnKey]
				  ,a.[ProductId]
				  ,a.[SpecificationName]
				  ,a.[SpecificationDtls]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.ProdSpcfctnId ASC) AS RowNum 
      FROM  [invnt].[ProductSpecifications] a
	  WHERE  (@ProdSpcfctnId IS NULL OR a.ProdSpcfctnId = @ProdSpcfctnId) and 
		     (@ProdSpcfctnKey IS NULL OR a.ProdSpcfctnKey = @ProdSpcfctnKey) and
			 (@ProductId IS NULL OR a.ProductId = @ProductId) and
			 (@SpecificationName IS NULL OR a.SpecificationName = @SpecificationName) and
			 (@SpecificationDtls IS NULL OR a.SpecificationDtls = @SpecificationDtls) and
		     (@SpecificationName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.SpecificationName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SpecificationName, ' ', ''))))  + '%')
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
        a.ProdSpcfctnId DESC;
  END