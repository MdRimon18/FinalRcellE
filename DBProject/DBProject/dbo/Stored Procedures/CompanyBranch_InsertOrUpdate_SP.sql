

CREATE PROCEDURE [dbo].[CompanyBranch_InsertOrUpdate_SP](
	    @BranchId bigint,
		@BranchKey uniqueidentifier,
		@CompanyId bigint,
		@BranchName nvarchar(100),
		@MobileNo nvarchar(100),
		@Email nvarchar(100)= NULL,
		@StateName nvarchar(100),
		@Address nvarchar(max),
		@BrnchManagerName nvarchar(100)= NULL,
		@ManagerMobile nvarchar(100)= NULL,
		@BranchImgLink nvarchar(180)= NULL,
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
			FROM [stt].[CompanyBranch]  
			WHERE
			Status='Active' and
			@BranchId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([BranchName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@BranchName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@BranchId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[CompanyBranch] (
				   [BranchKey]
				  ,[CompanyId]
				  ,[BranchName]
				  ,[MobileNo]
				  ,[Email]
				  ,[StateName]
				  ,[Address]
				  ,[BrnchManagerName]
				  ,[ManagerMobile]
				  ,[BranchImgLink]
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
			    @CompanyId,
				@BranchName,
				@MobileNo,
				@Email,			
				@StateName,
	            @Address,
	            @BrnchManagerName,
				@ManagerMobile,
	            @BranchImgLink,	         
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
					 [CompanyId]=@CompanyId,
                      [BranchName]=@BranchName,
                      [MobileNo]=@MobileNo,
                      [Email]=@Email,
                      [StateName]=@StateName,
                      [Address]=@Address,
                      [BrnchManagerName]=@BrnchManagerName,
                      [ManagerMobile]=@ManagerMobile,
                      [BranchImgLink]=@BranchImgLink,				
					  [EntryDateTime] =@EntryDateTime,
					  [EntryBy] =@EntryBy,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
			 	   	[stt].[CompanyBranch]  a WITH(ROWLOCK)	
					  WHERE 
					  a.BranchId=@BranchId 

					 SET @SuccessOrFailId = @BranchId ; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]