
CREATE PROCEDURE [dbo].[Suppliers_InsertOrUpdate_SP](
    @SupplierId BIGINT, 
    @SupplierKey uniqueidentifier=null,
    @BranchId bigint,
	@SupplrName nvarchar(100),
	@MobileNo nvarchar(100),
	@Email nvarchar(100),
	@SuppOrgnznName nvarchar(200),
	@CountryId bigint,
	@StateName nvarchar(100),
	@BusinessTypeId bigint,
	@SupplrAddrssOne nvarchar(max),
	@SupplrAddrssTwo nvarchar(max)=null,
	@DeliveryOffDay nvarchar(80)=null,
	@SupplrImgLink nvarchar(180)=null,

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
			FROM [stt].[Suppliers]  
			WHERE
			Status='Active' and
			@SupplierId=0 and
			BranchId=@BranchId and
			LOWER(LTRIM(RTRIM(REPLACE([SupplrName], ' ', ''))))= LOWER(LTRIM(RTRIM(REPLACE(@SupplrName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@SupplierId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Suppliers] (
				   [SupplierKey]
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
			   ) 
		VALUES (
				NEWID(),  
				@BranchId,
				@SupplrName,
				@MobileNo,
				@Email,
				@SuppOrgnznName,
				@CountryId,
				@StateName,
				@BusinessTypeId,
	            @SupplrAddrssOne,
	            @SupplrAddrssTwo,
	            @DeliveryOffDay,
	            @SupplrImgLink,
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
					   [BranchId]=@BranchId,
                       [SupplrName]=@SupplrName,
                       [MobileNo]=@MobileNo,
                       [Email]=@Email,
                       [SuppOrgnznName]=@SuppOrgnznName,
                       [CountryId]=@CountryId,
                       [StateName]=@StateName,
                       [BusinessTypeId]=@BusinessTypeId,
                       [SupplrAddrssOne]=@SupplrAddrssOne,
                       [SupplrAddrssTwo]=@SupplrAddrssTwo,
                       [DeliveryOffDay]=@DeliveryOffDay,
                       [SupplrImgLink]=@SupplrImgLink,
				
					   [EntryDateTime] = COALESCE(@EntryDateTime, [EntryDateTime]),
					   [EntryBy] = COALESCE(@EntryBy, [EntryBy]),

					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[Suppliers] a WITH(ROWLOCK) 
					  WHERE 
					  a.SupplierId = @SupplierId

					 SET @SuccessOrFailId = @SupplierId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]