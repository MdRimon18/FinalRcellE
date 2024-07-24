
CREATE PROCEDURE [dbo].[User_InsertOrUpdate_SP](
	 @UserId bigint=null,
	 @UserKey nvarchar(40)=null,
	 @UserName nvarchar(100)= NUll,
	 @UserPhoneNo nvarchar(100),
	 @UserPassword nvarchar(20),
	 @UserDesignation nvarchar(100)=NULL,
	 @UserImgLink nvarchar(180)= NULL, 

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
			FROM [stt].[Users]  
			WHERE
			Status='Active' and
			@UserId =0 and
			LOWER(LTRIM(RTRIM(REPLACE([UserName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@UserName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@UserId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Users] (
				   [UserKey]
				  ,[UserName]
				  ,[UserPhoneNo]
				  ,[UserPassword]
				  ,[UserDesignation]
				  ,[UserImgLink]
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
				
				  @UserName,
				  @UserPhoneNo,
				  @UserPassword,
				  @UserDesignation,
				  @UserImgLink,
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
					  
					  [UserName]=@UserName,
					  [UserPhoneNo]=@UserPhoneNo,
					  [UserPassword]=@UserPassword,
					  [UserDesignation]=@UserDesignation,
					  [UserImgLink]=@UserImgLink,				  
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[Users] a WITH(ROWLOCK) 
					  WHERE 
					  a.UserId = @UserId 

					 SET @SuccessOrFailId = @UserId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]