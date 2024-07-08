
 Create PROCEDURE [dbo].[Invoices_GetSp](
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
	@EntryDateTime datetime= NULL,
	@EntryBy bigint =NULL,
	@LastModifyDate datetime= NULL,
	@LastModifyBy bigint= NULL,
	@DeletedDate datetime= NULL,
	@DeletedBy bigint= NULL,
	@Status varchar(10)= NULL,
	@PageNumber int=1,
	@PageSize int=10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[InvoiceId]
      ,a.[InvoiceKey]
      ,a.[BranchId]
      ,a.[InvoiceNumber]
      ,a.[CustomerID]
      ,a.[InvoiceDateTime]
      ,a.[InvoiceTypeId]
      ,a.[NotificationById]
      ,a.[SalesByName]
      ,a.[Notes]
      ,a.[PaymentTypeId]
      ,a.[PaymentReference]
      ,a.[ShippingMethodId]
      ,a.[CurrencyId]
      ,a.[OrderStatusId]
      ,a.[TotalQnty]
      ,a.[TotalAmount]
      ,a.[TotalVat]
      ,a.[TotalDiscount]
      ,a.[TotalAddiDiscount]
      ,a.[TotalPayable]
      ,a.[RecieveAmount]
      ,a.[DueAmount]
      ,a.[DuePaymentDate]
      ,a.[PromoOrCupponId]
      ,a.[PolicyId]
      ,a.[DeliveryDate]
      ,a.[PriorityLevelId]
      ,a.[GiftOrder]
      ,a.[VoucherCode]
      ,a.[ShipmentTrackingNumber]
      ,a.[ExchangeRate]
      ,a.[ExpirationDate]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.InvoiceId ASC) AS RowNum 
      FROM   [invnt].[Invoice] a
	  WHERE  (@InvoiceId IS NULL OR a.InvoiceId = @InvoiceId) and
	         (@InvoiceKey IS NULL OR a.InvoiceKey = @InvoiceKey) and
			 (@BranchId IS NULL OR a.BranchId = @BranchId) and
			  (@InvoiceNumber IS NULL OR a.InvoiceNumber = @InvoiceNumber) and
			   (@CustomerID IS NULL OR a.CustomerID = @CustomerID) and
			   (@InvoiceDateTime IS NULL OR a.InvoiceDateTime = @InvoiceDateTime) and
			  (@InvoiceTypeId IS NULL OR a.InvoiceTypeId = @InvoiceTypeId) and
			   (@NotificationById IS NULL OR a.NotificationById = @NotificationById) and
			   (@SalesByName IS NULL OR a.SalesByName = @SalesByName) and
			  (@Notes IS NULL OR a.Notes= @Notes) and
			   (@PaymentTypeId IS NULL OR a.PaymentTypeId = @PaymentTypeId) and
			   (@PaymentReference IS NULL OR a.PaymentReference= @PaymentReference) and
			   (@ShippingMethodId IS NULL OR a.ShippingMethodId = @ShippingMethodId) and
			   (@CurrencyId IS NULL OR a.CurrencyId = @CurrencyId) and
			   (@OrderStatusId IS NULL OR a.OrderStatusId = @OrderStatusId) and
			   (@TotalQnty IS NULL OR a.TotalQnty = @TotalQnty) and
			   (@TotalAmount IS NULL OR a.TotalAmount = @TotalAmount) and
			   (@TotalVat IS NULL OR a.TotalVat = @TotalVat) and
			   (@TotalDiscount IS NULL OR a.TotalDiscount = @TotalDiscount) and
               (@TotalPayable IS NULL OR a.TotalPayable = @TotalPayable) and
			   (@RecieveAmount IS NULL OR a.RecieveAmount= @RecieveAmount) and
			   (@DueAmount IS NULL OR a.DueAmount = @DueAmount) and
			   (@DuePaymentDate IS NULL OR a.DuePaymentDate = @DuePaymentDate) and
			   (@PriorityLevelId IS NULL OR a.PriorityLevelId = @PriorityLevelId) and
			   (@GiftOrder IS NULL OR a.GiftOrder = @GiftOrder) and
			   (@VoucherCode IS NULL OR a.VoucherCode= @VoucherCode) and
			   (@ShipmentTrackingNumber IS NULL OR a.ShipmentTrackingNumber = @ShipmentTrackingNumber) and
               (@ExchangeRate IS NULL OR a.ExchangeRate = @ExchangeRate) and
			   (@ExpirationDate IS NULL OR a.ExpirationDate= @ExpirationDate) and

		     (@SalesByName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.SalesByName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SalesByName, ' ', ''))))  + '%')
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
        a.InvoiceId DESC;
  END