
CREATE PROCEDURE [dbo].[ProductSpecifications_InsertOrUpdate_SP](
  @ProdSpcfctnId BIGINT, 
  @ProdSpcfctnKey uniqueidentifier=null,
  @ProductId BIGINT,
  @SpecificationName NVARCHAR(150), 
  @SpecificationDtls nvarchar(max)=null,	
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
			FROM [invnt].[ProductSpecifications]  
			WHERE
			Status='Active' and
			@ProdSpcfctnId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([SpecificationName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@SpecificationName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@ProdSpcfctnId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [invnt].[ProductSpecifications] (
				   [ProdSpcfctnKey]
				  ,[ProductId]
				  ,[SpecificationName]
				  ,[SpecificationDtls]
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
				@ProductId,
				@SpecificationName,
				@SpecificationDtls,
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
					  
					  [SpecificationName] = @SpecificationName,
					  [ProductId]=@ProductId,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [invnt].[ProductSpecifications] a WITH(ROWLOCK) 
					  WHERE 
					  a.ProdSpcfctnId = @ProdSpcfctnId 

					 SET @SuccessOrFailId = @ProdSpcfctnId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]