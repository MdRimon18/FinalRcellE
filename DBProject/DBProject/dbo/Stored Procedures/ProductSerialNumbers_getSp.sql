

 CREATE PROCEDURE [dbo].[ProductSerialNumbers_getSp](
 @ProdSerialNmbrId bigint=null,
 @ProdSerialNmbrKey nvarchar(40)=null,
 @ProductId bigint,	
 @SerialNumber nvarchar(150)=NULL,
 @TagSupplierId bigint=null,	
 @Remarks nvarchar(max)=null,
 @SerialStatus nvarchar(15),
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[ProdSerialNmbrId]
				  ,a.[ProdSerialNmbrKey]
				  ,a.[ProductId]
				  ,a.[SerialNumber]
				  ,a.[TagSupplierId]
				  ,a.[Remarks]
				  ,a.[SerialStatus]
				  
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.ProdSerialNmbrId ASC) AS RowNum 
      FROM   [invnt].[ProductSerialNumbers] a
	  WHERE  (@ProdSerialNmbrId IS NULL OR a.ProdSerialNmbrId = @ProdSerialNmbrId) and
	         (@ProdSerialNmbrKey IS NULL OR a.ProdSerialNmbrKey = @ProdSerialNmbrKey) and
			 (@ProductId IS NULL OR a.ProductId = @ProductId) and
			 (@SerialNumber IS NULL OR a.SerialNumber = @SerialNumber) and
			 (@TagSupplierId IS NULL OR a.TagSupplierId = @TagSupplierId) and
			 (@Remarks IS NULL OR a.Remarks = @Remarks) and
		     (@SerialStatus IS NULL OR a.SerialStatus = @SerialStatus) and
		     (@SerialNumber IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.SerialNumber, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SerialNumber, ' ', ''))))  + '%')
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
        a.ProdSerialNmbrId DESC;
  END