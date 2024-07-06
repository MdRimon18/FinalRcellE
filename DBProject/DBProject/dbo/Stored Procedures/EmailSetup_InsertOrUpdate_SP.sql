CREATE PROCEDURE [dbo].[EmailSetup_InsertOrUpdate_SP](
 @EmailSetupId int,
 --@EmailSetupkey uniqueidentifier=NULL,
 @BranchId bigint,
 @FromEmail nvarchar(150)= NULL,
 @FromName nvarchar(150)= NULL,
 @UserName nvarchar(150)= NULL,
 @Password nvarchar(500)= NULL,
 @BaseUrl nvarchar(250)= NULL,
 @ApiKey nvarchar(500)= NULL,
 @PortNumber bigint= null,
 @IsDefault bit=0,

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
			FROM  [stt].[EmailSetup] 
			WHERE
			Status='Active' and
			@EmailSetupId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([FromName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@FromName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@EmailSetupId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO  [stt].[EmailSetup] (
				   [EmailSetupkey]
                   ,[BranchId]
				   ,[FromEmail]
                  ,[FromName]
                  ,[UserName]
                  ,[Password]
                  ,[BaseUrl]
                  ,[ApiKey]
                  ,[PortNumber]
                  ,[IsDefault]
				  
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
				@FromEmail,
				@FromName,
				
				
				@UserName,
				@Password,
				@BaseUrl,
				@ApiKey,
				@PortNumber,
				@IsDefault,

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
					  
					  [FromName] = @FromName,	
					  [FromEmail]=@FromEmail,
					  [UserName]=@UserName,
					  [BranchId]=@BranchId,
					  [Password]=@Password,
					  [BaseUrl]=@BaseUrl,
					  [ApiKey]=@ApiKey,
					  [IsDefault]=@IsDefault,
					  [PortNumber]=@PortNumber,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[EmailSetup] a WITH(ROWLOCK) 
					  WHERE 
					  a.EmailSetupId = @EmailSetupId 

					 SET @SuccessOrFailId = @EmailSetupId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]