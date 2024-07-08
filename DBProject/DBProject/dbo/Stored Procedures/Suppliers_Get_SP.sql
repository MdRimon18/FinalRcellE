

 CREATE PROCEDURE [dbo].[Suppliers_Get_SP](
 @SupplierId bigint=null,
 @SupplierKey nvarchar(40)=null,
 @SupplrName nvarchar(100)=null,
 @SuppOrgnznName nvarchar(200),
 @MobileNo nvarchar(100),
 @Email nvarchar(100)= NULL,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT [SupplierId]
				  ,[SupplierKey]
				  ,[BranchId]
				  ,[SupplrName]
				  ,[MobileNo]
				  ,[Email]
				  ,[SuppOrgnznName]
				  ,[CountryId]
				  ,[StateName]
				  ,[BusinessTypeId]
				  ,[SupplrAddrssOne]
				  ,[SupplrAddrssTwo]
				  ,[DeliveryOffDay]
				  ,[SupplrImgLink]
				  ,[EntryDateTime]
				  ,[EntryBy]
				  ,[LastModifyDate]
				  ,[LastModifyBy]
				  ,[DeletedDate]
				  ,[DeletedBy]
				  ,[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.SupplierId ASC) AS RowNum 
      FROM   [stt].[Suppliers] a
	  WHERE  (@SupplierId IS NULL OR a.SupplierId = @SupplierId) and
	         (@SupplierKey IS NULL OR a.SupplierKey = @SupplierKey) and
			 (@SuppOrgnznName IS NULL OR a.SuppOrgnznName = @SuppOrgnznName) and
			 (@MobileNo IS NULL OR a.MobileNo = @MobileNo) and
			 (@Email IS NULL OR a.Email = @Email) and
		     (@SupplrName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.SupplrName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SupplrName, ' ', ''))))  + '%')
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
        a.SupplierId DESC;
  END