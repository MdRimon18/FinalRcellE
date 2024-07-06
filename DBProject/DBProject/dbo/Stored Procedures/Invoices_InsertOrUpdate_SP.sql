
Create PROCEDURE [dbo].[Invoices_InsertOrUpdate_SP](
    @InvoiceId bigint,
	@InvoiceKey uniqueidentifier,
	@BranchId bigint,
	@InvoiceNumber nvarchar(50),
	@CustomerID int,
	@InvoiceDateTime datetime,
	@InvoiceTypeId bigint,
	@NotificationById bigint,
	@SalesByName nvarchar(100)= NULL,
	@Notes nvarchar(max) =NULL,
	@PaymentTypeId bigint,
	@PaymentReference nvarchar(150)= NULL,
	@ShippingMethodId bigint= NULL,
	@CurrencyId bigint,
	@OrderStatusId bigint=NULL,
	@TotalQnty int,
	@TotalAmount decimal(10, 2),
	@TotalVat decimal(10, 2)=NULL,
	@TotalDiscount decimal(10, 2)= NULL,
	@TotalAddiDiscount decimal(10, 2) =NULL,
	@TotalPayable decimal(10, 2),
	@RecieveAmount decimal(10, 2),
	@DueAmount decimal(10, 2)= NULL,
	@DuePaymentDate datetime= NULL,
	@PromoOrCupponId bigint= NULL,
	@PolicyId bigint=NULL,
	@DeliveryDate datetime= NULL,
	@PriorityLevelId int= NULL,
	@GiftOrder bit= NULL,
	@VoucherCode nvarchar(50)= NULL,
	@ShipmentTrackingNumber nvarchar(100)= NULL,
	@ExchangeRate decimal(18, 6)= NULL,
	@ExpirationDate datetime= NULL,
    @EntryDateTime DATETIME=NUll,
    @EntryBy BIGINT=NULL,
    @LastModifyDate DATETIME = NULL,
    @LastModifyBy BIGINT = NULL,
    @DeletedDate DATETIME = NULL,
    @DeletedBy BIGINT = NULL,
    @Status VARCHAR(10)=NuLL,
    @SuccessOrFailId INT OUTPUT
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM  [invnt].[Invoice] 
			WHERE
			Status='Active' and
			@InvoiceId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([SalesByName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@SalesByName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@InvoiceId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [invnt].[Invoice] (
				   [InvoiceKey]
      ,[BranchId]
      ,[InvoiceNumber]
      ,[CustomerID]
      ,[InvoiceDateTime]
      ,[InvoiceTypeId]
      ,[NotificationById]
      ,[SalesByName]
      ,[Notes]
      ,[PaymentTypeId]
      ,[PaymentReference]
      ,[ShippingMethodId]
      ,[CurrencyId]
      ,[OrderStatusId]
      ,[TotalQnty]
      ,[TotalAmount]
      ,[TotalVat]
      ,[TotalDiscount]
      ,[TotalAddiDiscount]
      ,[TotalPayable]
      ,[RecieveAmount]
      ,[DueAmount]
      ,[DuePaymentDate]
      ,[PromoOrCupponId]
      ,[PolicyId]
      ,[DeliveryDate]
      ,[PriorityLevelId]
      ,[GiftOrder]
      ,[VoucherCode]
      ,[ShipmentTrackingNumber]
      ,[ExchangeRate]
      ,[ExpirationDate]
				  ,[EntryDateTime]
				  ,[EntryBy]
				  ,[LastModifyDate]
				  ,[LastModifyBy]
				  ,[DeletedDate]
				  ,[DeletedBy]
				  ,[Status]
			   ) 
		VALUES (
				NEWID(),  
				@BranchId,
      @InvoiceNumber,
      @CustomerID,
      @InvoiceDateTime,
      @InvoiceTypeId,
      @NotificationById,
      @SalesByName,
      @Notes,
      @PaymentTypeId,
      @PaymentReference,
      @ShippingMethodId,
      @CurrencyId,
      @OrderStatusId,
      @TotalQnty,
      @TotalAmount,
      @TotalVat,
      @TotalDiscount,
      @TotalAddiDiscount,
      @TotalPayable,
      @RecieveAmount,
      @DueAmount,
      @DuePaymentDate,
      @PromoOrCupponId,
      @PolicyId,
      @DeliveryDate,
      @PriorityLevelId,
      @GiftOrder,
      @VoucherCode,
      @ShipmentTrackingNumber,
      @ExchangeRate,
      @ExpirationDate,
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
  [SalesByName]= @SalesByName,
          [BranchId]= @BranchId,
[InvoiceNumber]= @InvoiceNumber,
    [CustomerID] = @CustomerID,
  [InvoiceDateTime] = @InvoiceDateTime,
     [InvoiceTypeId]= @InvoiceTypeId,
     [NotificationById] = @NotificationById,
   
    [Notes] = @Notes,
     [PaymentTypeId]= @PaymentTypeId,
     [PaymentReference]= @PaymentReference,
     [ShippingMethodId]= @ShippingMethodId,
     [CurrencyId]= @CurrencyId,
    [OrderStatusId] = @OrderStatusId,
     [TotalQnty] =@TotalQnty,
    [TotalAmount] = @TotalAmount,
     [TotalVat] =@TotalVat,
     [TotalDiscount] =@TotalDiscount,
      [TotalAddiDiscount]=@TotalAddiDiscount,
    [TotalPayable] = @TotalPayable,
    [RecieveAmount] = @RecieveAmount,
     [DueAmount] =@DueAmount,
    [DuePaymentDate] = @DuePaymentDate,
     [PromoOrCupponId]= @PromoOrCupponId,
    [PolicyId] = @PolicyId,
     [DeliveryDate] = @DeliveryDate,
     [PriorityLevelId] =@PriorityLevelId,
    [GiftOrder] = @GiftOrder,
   [VoucherCode] = @VoucherCode,
    [ShipmentTrackingNumber] = @ShipmentTrackingNumber,
    [ExchangeRate] = @ExchangeRate,
  [ExpirationDate] =  @ExpirationDate,					 
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [invnt].[Invoice] a WITH(ROWLOCK) 
					  WHERE 
					  a.InvoiceId = @InvoiceId 

					 SET @SuccessOrFailId = @InvoiceId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]