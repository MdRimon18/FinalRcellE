 
CREATE PROCEDURE [dbo].[BillingPlan_InsertOrUpdate_SP](
  @BillingPlanId BIGINT, 
  @BillingPlanKey uniqueidentifier=null,
  @LanguageId BIGINT,
  @BillingPlanName NVARCHAR(100), 
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
			FROM [stt].[BillingPlans]  
			WHERE
			Status='Active' and
			@BillingPlanId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([BillingPlanName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@BillingPlanName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@BillingPlanId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[BillingPlans] (
				   [BillingPlanKey]
				  ,[LanguageId]
				  ,[BillingPlanName]
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
				@BillingPlanName,
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
					  
					  [BillingPlanName] = @BillingPlanName,
					  [LanguageId]=@LanguageId,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[BillingPlans] a WITH(ROWLOCK) 
					  WHERE 
					  a.BillingPlanId = @BillingPlanId 

					 SET @SuccessOrFailId = @BillingPlanId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]