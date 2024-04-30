Create PROCEDURE [dbo].[Prdct_Sub_Ctg_InsertOrUpdate_SP](
  @ProdSubCtgId BIGINT, 
  @ProdSubCtgKey uniqueidentifier=null,
  @BranchId BIGINT,
  @ProdCtgId BIGINT,
  @ProdSubCtgName NVARCHAR(100), 
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
			FROM [invnt].[ProductSubCategories]  
			WHERE
			Status='Active' and
			@ProdSubCtgId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([ProdSubCtgName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@ProdSubCtgName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@ProdSubCtgId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [invnt].[ProductSubCategories] (
				   [ProdSubCtgKey]
				  ,[BranchId]
				  ,[ProdCtgId]
				  ,[ProdSubCtgName]
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
				@ProdCtgId,
				@ProdSubCtgName,
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
					  [BranchId]= @BranchId,
					  [ProdCtgId]= @ProdCtgId,
					  [ProdSubCtgName] = @ProdSubCtgName,				  
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [invnt].[ProductSubCategories] a WITH(ROWLOCK) 
					  WHERE 
					  a.ProdSubCtgId = @ProdSubCtgId 

					 SET @SuccessOrFailId = @ProdSubCtgId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]