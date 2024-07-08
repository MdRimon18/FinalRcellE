

 CREATE PROCEDURE [dbo].[Products_GetSp](
	 @ProductId bigint,
	 @ProductKey nvarchar(40)=null,
	 @BranchId bigint,
	 @ProdCtgId bigint,
	 @TagWord nvarchar(250)=NULL,
	 @ProdName nvarchar (150),
	 @ManufacturarName nvarchar (150)=NULL,
	 @SerialNmbrOrUPC nvarchar (150)= NULL,
	 @Sku nvarchar (150)= NULL,
	 @BarCode nvarchar(250)= NULL,
	 @SupplirLinkId int =NULL,
	 @ColorId int= NULL,
	 @SizeId int =NULL,
	 @ShippingById int =NULL,
	 @Rating int =NULL,
	 @ProdStatusId int =NULL,
	 @PageNumber INT = 1,
	 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[ProductId]
				  ,a.[ProductKey]
				  ,a.[ProdCtgId]
				  ,a.[ProdSubCtgId]
				  ,a.[UnitId]
				  ,a.[FinalPrice]
				  ,a.[PreviousPrice]
				  ,a.[CurrencyId]
				  ,a.[TagWord]
				  ,a.[ProdName]
				  ,a.[ManufacturarName]
				  ,a.[SerialNmbrOrUPC]
				  ,a.[Sku]
				  ,a.[OpeningQnty]
				  ,a.[AlertQnty]
				  ,a.[BuyingPrice]
				  ,a.[SellingPrice]
				  ,a.[VatPercent]
				  ,a.[VatAmount]
				  ,a.[DiscountPercentg]
				  ,a.[DiscountAmount]
				  ,a.[BarCode]
				  ,a.[SupplirLinkId]
				  ,a.[ImportedForm]
				  ,a.[ImportStatusId]
				  ,a.[GivenEntryDate]
				  ,a.[WarrentYear]
				  ,a.[WarrentyPolicy]
				  ,a.[ColorId]
				  ,a.[SizeId]
				  ,a.[ShippingById]
				  ,a.[ShippingDays]
				  ,a.[ShippingDetails]
				  ,a.[OriginCountryId]
				  ,a.[Rating]
				  ,a.[ProdStatusId]
				  ,a.[Remarks]
				  ,a.[ProdDescription]
				  ,a.[ReleaseDate]
				  ,a.[BranchId]
				  ,a.[StockQuantity]
				  ,a.[ItemWeight]
				  ,a.[WarehouseId]
				  ,a.[RackNumber]
				  ,a.[BatchNumber]
				  ,a.[PolicyId]
				 ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[ProdStatus]
				  ,ROW_NUMBER() OVER (ORDER BY a.ProductId ASC) AS RowNum 
      FROM  [invnt].[Products] a
	  WHERE  (@ProductId IS NULL OR a.ProductId = @ProductId) and
	         (@ProductKey IS NULL OR a.ProductKey = @ProductKey) and
			 (@ProdCtgId IS NULL OR a.ProdCtgId = @ProdCtgId) and
			 
			 (@TagWord IS NULL OR a.TagWord = @TagWord) and
			 (@ProdName IS NULL OR a.ProdName = @ProdName) and
	         (@ManufacturarName IS NULL OR a.ManufacturarName = @ManufacturarName) and
			 (@SerialNmbrOrUPC IS NULL OR a.SerialNmbrOrUPC = @SerialNmbrOrUPC) and
			 (@Sku IS NULL OR a.Sku = @Sku) and
	          
			 (@BarCode IS NULL OR a.BarCode = @BarCode) and
	         (@SupplirLinkId IS NULL OR a.SupplirLinkId = @SupplirLinkId) and
			 
	         (@ColorId IS NULL OR a.ColorId = @ColorId) and
			 (@SizeId IS NULL OR a.SizeId = @SizeId) and
			  (@ShippingById IS NULL OR a.ShippingById = @ShippingById) and
			 
			  (@Rating IS NULL OR a.Rating = @Rating) and
			 (@ProdStatusId IS NULL OR a.ProdStatusId = @ProdStatusId) and
			    
			 (@ProdStatusId IS NULL OR a.ProdStatusId = @ProdStatusId) and
			   (@BranchId IS NULL OR a.BranchId = @BranchId) and
		     (@ProdName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.ProdName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@ProdName, ' ', ''))))  + '%')
			 and a.ProdStatus='Active'
      )
		SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > ((@PageNumber - 1) * @PageSize) AND RowNum <= (@PageNumber * @PageSize)     
        ORDER BY 
        a.ProductId DESC;
  END