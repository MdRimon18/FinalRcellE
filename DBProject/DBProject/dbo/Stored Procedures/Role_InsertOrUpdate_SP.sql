Create PROCEDURE [dbo].[Role_InsertOrUpdate_SP](
  @RoleId BIGINT, 
  @Rolekey uniqueidentifier=null,
  @RoleName NVARCHAR(100), 
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
			FROM [stt].[Role]  
			WHERE
			Status='Active' and
			@RoleId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([RoleName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@RoleName, ' ', ''))))
		)
		BEGIN 
			-- If RoleName already exists, set  @RoleId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@RoleId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Role] (
				   [Rolekey]
				  ,[RoleName]
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
				@RoleName,
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
					  
					  [RoleName] = @RoleName,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[Role] a WITH(ROWLOCK) 
					  WHERE 
					  a.RoleId = @RoleId 

					 SET @SuccessOrFailId = @RoleId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[Role]