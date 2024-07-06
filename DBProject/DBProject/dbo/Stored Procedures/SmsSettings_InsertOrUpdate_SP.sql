Create PROCEDURE [dbo].[SmsSettings_InsertOrUpdate_SP](
  @SmsSttngId BIGINT, 
  @SmsSttngKey uniqueidentifier=null,
  @BranchID BIGINT,
  @SmsTypeId bigint=NULL,
  @Title nvarchar(150),
  @SenderName NVARCHAR(100), 
  @SmsCode nvarchar (100)=NULL,
  @ApiUrl nvarchar (150),
  @UserName nvarchar (100)= NULL,
  @Password nvarchar (50)=NULL,
  @PortNumber nvarchar (50)= NULL,
  @IsDefault bit,
  @Remarks nvarchar (max)=NULL,
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
			FROM [stt].[SmsSettings]  
			WHERE
			Status='Active' and
			@SmsSttngId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([SenderName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@SenderName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@SmsSttngId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[SmsSettings] (
				   [SmsSttngKey]
                  ,[BranchID]
                  ,[SmsTypeId]
                  ,[Title]
                  ,[SenderName]
                  ,[SmsCode]
                  ,[ApiUrl]
                  ,[UserName]
                  ,[Password]
                  ,[PortNumber]
                  ,[IsDefault]
                  ,[Remarks]
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
				  @BranchID,
                  @SmsTypeId,
                  @Title,
                  @SenderName,
                  @SmsCode,
                  @ApiUrl,
                  @UserName,
                  @Password,
                  @PortNumber,
                  @IsDefault,
                  @Remarks,
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
					  [BranchID]= @BranchID,
                      [SmsTypeId]= @SmsTypeId,
                      [Title] = @Title,
                      [SenderName] = @SenderName,
                      [SmsCode] = @SmsCode,
                      [ApiUrl]= @ApiUrl,
                      [UserName]=@UserName,
                      [Password]=@Password,
                      [PortNumber]=@PortNumber,
                      [IsDefault] = @IsDefault,
                      [Remarks] =@Remarks,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[SmsSettings] a WITH(ROWLOCK) 
					  WHERE 
					  a.SmsSttngId = @SmsSttngId

					 SET @SuccessOrFailId = @SmsSttngId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]