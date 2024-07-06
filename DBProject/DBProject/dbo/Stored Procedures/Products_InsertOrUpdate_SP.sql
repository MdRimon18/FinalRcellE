
CREATE PROCEDURE [dbo].[Products_InsertOrUpdate_SP](
 @ProductId bigint,
 @ProductKey nvarchar(40)=null,
 @ProdCtgId bigint,
 @ProdSubCtgId bigint,
 @UnitId bigint,
 @FinalPrice decimal(10, 2),
 @PreviousPrice decimal(10, 2)=NULL,
 @CurrencyId bigint,
 @TagWord nvarchar(250)=NULL,
 @ProdName nvarchar (150),
 @ManufacturarName nvarchar (150)=NULL,
 @SerialNmbrOrUPC nvarchar (150)= NULL,
 @Sku nvarchar (150)= NULL,
 @OpeningQnty int,
 @AlertQnty int =NULL,
 @BuyingPrice decimal(10, 2),
	@SellingPrice decimal(10, 2) ,
	@VatPercent decimal(10, 2) =NULL,
	@VatAmount decimal(10, 2)= NULL,
	@DiscountPercentg decimal(10, 2)= NULL,
	@DiscountAmount decimal(10, 2)= NULL,
	@BarCode nvarchar(250)= NULL,
	@SupplirLinkId int =NULL,
	@ImportedForm nvarchar(150)= NULL,
	@ImportStatusId int= NULL,
	@GivenEntryDate datetime =NULL,
	@WarrentYear int =NULL,
	@WarrentyPolicy nvarchar(max) =NULL,
	@ColorId int= NULL,
	@SizeId int =NULL,
	@ShippingById int =NULL,
	@ShippingDays int =NULL,
	@ShippingDetails nvarchar (max) =NULL,
	@OriginCountryId int =NULL,
	@Rating int =NULL,
	@ProdStatusId int =NULL,
	@Remarks nvarchar (max) =NULL,
	@ProdDescription nvarchar (max)= NULL,
	@ReleaseDate datetime =NULL,
	@BranchId bigint,
	@StockQuantity int,
	@ItemWeight decimal (18, 2)= NULL,
	@WarehouseId bigint =NULL,
	@RackNumber nvarchar (50)= NULL,
	@BatchNumber nvarchar (50)= NULL,
	@PolicyId bigint = NULL,
  

  @EntryDateTime DATETIME=NUll,
  @EntryBy BIGINT=NULL,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @ProdStatus VARCHAR(10)=NuLL,
  @SuccessOrFailId INT OUTPUT
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM  [invnt].[Products]
			WHERE
		ProdStatus='Active' and
			@ProductId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([ProdName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE( @ProdName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@ProductId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO  [invnt].[Products] (
				   [ProductKey]
      ,[ProdCtgId]
      ,[ProdSubCtgId]
      ,[UnitId]
      ,[FinalPrice]
      ,[PreviousPrice]
      ,[CurrencyId]
      ,[TagWord]
      ,[ProdName]
      ,[ManufacturarName]
      ,[SerialNmbrOrUPC]
      ,[Sku]
      ,[OpeningQnty]
      ,[AlertQnty]
      ,[BuyingPrice]
      ,[SellingPrice]
      ,[VatPercent]
      ,[VatAmount]
      ,[DiscountPercentg]
      ,[DiscountAmount]
      ,[BarCode]
      ,[SupplirLinkId]
      ,[ImportedForm]
      ,[ImportStatusId]
      ,[GivenEntryDate]
      ,[WarrentYear]
      ,[WarrentyPolicy]
      ,[ColorId]
      ,[SizeId]
      ,[ShippingById]
      ,[ShippingDays]
      ,[ShippingDetails]
      ,[OriginCountryId]
      ,[Rating]
      ,[ProdStatusId]
      ,[Remarks]
      ,[ProdDescription]
      ,[ReleaseDate]
      ,[BranchId]
      ,[StockQuantity]
      ,[ItemWeight]
      ,[WarehouseId]
      ,[RackNumber]
      ,[BatchNumber]
      ,[PolicyId]
      ,[EntryDateTime]
      ,[EntryBy]
      ,[LastModifyDate]
      ,[LastModifyBy]
      ,[DeletedDate]
      ,[DeletedBy]
      ,[ProdStatus]
			   ) 
		VALUES (
				NEWID(),  
				@ProdCtgId,
      @ProdSubCtgId,
      @UnitId,
      @FinalPrice,
      @PreviousPrice,
      @CurrencyId,
      @TagWord,
      @ProdName,
      @ManufacturarName,
      @SerialNmbrOrUPC,
      @Sku,
      @OpeningQnty,
      @AlertQnty,
	  @BuyingPrice,
      @SellingPrice,
      @VatPercent,
      @VatAmount,
      @DiscountPercentg,
      @DiscountAmount,
      @BarCode,
      @SupplirLinkId,
      @ImportedForm,
      @ImportStatusId,
      @GivenEntryDate,
      @WarrentYear,
      @WarrentyPolicy,
      @ColorId,
      @SizeId,
      @ShippingById,
      @ShippingDays,
      @ShippingDetails,
      @OriginCountryId,
      @Rating,
      @ProdStatusId,
      @Remarks,
      @ProdDescription,
      @ReleaseDate,
      @BranchId,
	  @StockQuantity,
      @ItemWeight,
      @WarehouseId,
      @RackNumber,
      @BatchNumber,
      @PolicyId,


				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				'Active'
			);
			   SET @SuccessOrFailId = SCOPE_IDENTITY(); --Get Newly Created Id
             --  SELECT  @BillingPlanId AS BillingPlanId;  --Set Newly Created Id
			 
			  End
         Else
		   BEGIN TRY  --try start for update
					UPDATE 
					a WITH(ROWLOCK) 
					SET 
					  
					  [ProdSubCtgId] = @ProdSubCtgId,
					  [UnitId]=@UnitId,
					  [FinalPrice] = @FinalPrice,     
     			      [PreviousPrice]=@PreviousPrice, 					 
					  [CurrencyId] = @CurrencyId,
					  [TagWord]=@TagWord,
					  [ProdName] = @ProdName,
					  [ManufacturarName]=@ManufacturarName,	  
					  [SerialNmbrOrUPC]=@SerialNmbrOrUPC,  
					  [Sku]=@Sku,
					  [OpeningQnty]=@OpeningQnty,
					  [AlertQnty] = @AlertQnty,				 
					  [BuyingPrice] = @BuyingPrice,
					  [SellingPrice]=@SellingPrice,
					  [VatPercent] = @VatPercent,
					  [VatAmount]=@VatAmount, 
					  [DiscountPercentg]=@DiscountPercentg,
					  [DiscountAmount] = @DiscountAmount,
					  [BarCode]=@BarCode,
					  [SupplirLinkId] = @SupplirLinkId,
					  [ImportedForm]=@ImportedForm,
					  [ImportStatusId] = @ImportStatusId,
					  [GivenEntryDate]=@GivenEntryDate, 					
					  [WarrentYear]=@WarrentYear,
					  [WarrentyPolicy] = @WarrentyPolicy,
					  [ColorId]=@ColorId,
					  [SizeId] = @SizeId,
					  [ShippingById]=@ShippingById,
					  [ShippingDays] = @ShippingDays,
					  [ShippingDetails]=@ShippingDetails,
					  [OriginCountryId] = @OriginCountryId,
					  [Rating] = @Rating,
					  [ProdStatusId]=@ProdStatusId,
					  [Remarks] = @Remarks,
					  [ProdDescription]=@ProdDescription,
					  [ReleaseDate] = @ReleaseDate,
					  [BranchId]=@BranchId,
					  [StockQuantity] =@StockQuantity,
					  [ItemWeight]= @ItemWeight,
					  [WarehouseId]=@WarehouseId,
					  [RackNumber] = @RackNumber,
					  [BatchNumber]=@BatchNumber, 
					  [PolicyId] = @PolicyId,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [ProdStatus] = COALESCE(@ProdStatus, [ProdStatus])
					 FROM 
					  [invnt].[Products] a WITH(ROWLOCK) 
					  WHERE 
					  a.ProductId = @ProductId 

					 SET @SuccessOrFailId = @ProductId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]