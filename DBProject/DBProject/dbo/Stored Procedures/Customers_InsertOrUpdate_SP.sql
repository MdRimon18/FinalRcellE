
CREATE PROCEDURE [dbo].[Customers_InsertOrUpdate_SP](
  @CustomerId BIGINT, 
  @CustomerKey uniqueidentifier=null,
  @BranchId bigint,
  @CustomerName nvarchar(100),
  @MobileNo nvarchar(100),
  @Email nvarchar(100)=null,
  @CountryId bigint,
  @StateName nvarchar(100),
  @CustAddrssOne nvarchar(max),
  @CustAddrssTwo nvarchar(max)=null,
  @Occupation nvarchar(100)=null,
  @OfficeName nvarchar(100)=null,
  @CustImgLink nvarchar(180)=null,
  @EntryDateTime DATETIME,
  @EntryBy BIGINT,
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
			FROM [stt].[Customers]  
			WHERE
			Status='Active' and
			@CustomerId =0 and
			LOWER(LTRIM(RTRIM(REPLACE([CustomerName ], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@CustomerName , ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@CustomerId =0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Customers] (
				
       [CustomerKey]
      ,[BranchId]
      ,[CustomerName]
      ,[MobileNo]
      ,[Email]
  
      ,[CountryId]
      ,[StateName]
      
      
      ,[CustAddrssOne]
      ,[CustAddrssTwo]
      ,[Occupation]
	  ,[OfficeName]
	  ,[CustImgLink]
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
				@CustomerName,
				@MobileNo,
				@Email,
				@CountryId,
				@StateName,
	            @CustAddrssOne,
	            @CustAddrssTwo,
	            @Occupation,
	            @OfficeName,
				@CustImgLink,
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
                       [CustomerName]=@CustomerName,
                       [MobileNo]=@MobileNo,
                       [Email]=@Email,
                       [CountryId]=@CountryId,
                       [StateName]=@StateName,
                       [CustAddrssOne]=@CustAddrssOne,
                       [CustAddrssTwo]=@CustAddrssTwo,
                       [Occupation]=@Occupation,
                       [OfficeName]=@OfficeName,
					   [CustImgLink]=@CustImgLink,
				
					  [EntryDateTime] =@EntryDateTime,
					  [EntryBy] =@EntryBy,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[Customers] a WITH(ROWLOCK) 
					  WHERE 
					  a.CustomerId  = @CustomerId 

					 SET @SuccessOrFailId = @CustomerId ; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]