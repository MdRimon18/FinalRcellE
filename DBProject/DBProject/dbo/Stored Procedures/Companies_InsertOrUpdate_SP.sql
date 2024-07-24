
CREATE PROCEDURE [dbo].[Companies_InsertOrUpdate_SP](
    @CompanyId bigint,
	@CompanyKey uniqueidentifier=NULL,
	@LanguageId int,
	@OwnerOrUserId bigint,
	@CompanyName nvarchar(150),
	@BusinessTypeId bigint,
	@CompMobileNo nvarchar(100),
	@CompanyEmail nvarchar(100)=NULL,
	@CountryId bigint,
	@StateName nvarchar(100),
	@CompAddrss nvarchar(max),
	@CurrencyId bigint,
	@BillingPlanId bigint,
	@WorkingDays nvarchar(100)=NULL,
	@StartToEndTime nvarchar(100)=NULL,
	@CompanyLogoImgLink nvarchar(180)= NULL,
	@IsHasBranch bit,
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
			FROM [stt].[Companies]  
			WHERE
			Status='Active' and
			@CompanyId=0 and
			LOWER(LTRIM(RTRIM(REPLACE(CompanyName, ' ', ''))))= LOWER(LTRIM(RTRIM(REPLACE(@CompanyName, ' ', ''))))
		--	or
		--	LOWER(LTRIM(RTRIM(REPLACE(CompMobileNo, ' ', ''))))= LOWER(LTRIM(RTRIM(REPLACE(@CompMobileNo, ' ', ''))))
		)
		BEGIN 
			
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@CompanyId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Companies] (
				   [CompanyKey]
				   ,LanguageId
				  ,[OwnerOrUserId]
				  ,[CompanyName]
				  ,[BusinessTypeId]
				  ,[CompMobileNo]
				  ,[CompanyEmail]
				  ,[CountryId]
				  ,[StateName]
				  ,[CompAddrss]
				  ,[CurrencyId]
				  ,[BillingPlanId]
				  ,[WorkingDays]
				  ,[StartToEndTime]
				  ,[CompanyLogoImgLink]
				  ,[IsHasBranch]
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
				@LanguageId,
				  @OwnerOrUserId,
				  @CompanyName,
				  @BusinessTypeId,
				  @CompMobileNo,
				  @CompanyEmail,
				  @CountryId,
				  @StateName,
				  @CompAddrss,
				  @CurrencyId,
				  @BillingPlanId,
				  @WorkingDays,
				  @StartToEndTime,
				  @CompanyLogoImgLink,
				  @IsHasBranch,
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
					   LanguageId=@LanguageId,
		               [OwnerOrUserId]=@OwnerOrUserId,
				  	   [CompanyName]=@CompanyName,
                       [BusinessTypeId]=@BusinessTypeId,
                       [CompMobileNo]=@CompMobileNo,
                       [CompanyEmail]=@CompanyEmail,
                       [CountryId]=@CountryId,
                       [StateName]=@StateName,
                       [CompAddrss]=@CompAddrss,
                       [CurrencyId]=@CurrencyId,
                       [BillingPlanId]=@BillingPlanId,
                       [WorkingDays]=@WorkingDays,
                       [StartToEndTime]=@StartToEndTime,
                       [CompanyLogoImgLink]=@CompanyLogoImgLink,
				       [IsHasBranch]=@IsHasBranch,
					   [EntryDateTime] = COALESCE(@EntryDateTime, [EntryDateTime]),
					   [EntryBy] = COALESCE(@EntryBy, [EntryBy]),
					   [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					   [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					   [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					   [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					   [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[Companies] a WITH(ROWLOCK) 
					  WHERE 
					  a.CompanyId = @CompanyId

					 SET @SuccessOrFailId = @CompanyId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]