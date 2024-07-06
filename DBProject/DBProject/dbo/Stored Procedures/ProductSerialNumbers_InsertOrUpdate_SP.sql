
Create PROCEDURE [dbo].[ProductSerialNumbers_InsertOrUpdate_SP](
  @ProdSerialNmbrId bigint=null,
  @ProdSerialNmbrKey nvarchar(40)=null,
  @ProductId bigint,	
  @SerialNumber nvarchar(150)=NULL,
  @TagSupplierId bigint=null,	
  @Remarks nvarchar(max)=null,
  @SerialStatus nvarchar(15),
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
			FROM [invnt].[ProductSerialNumbers]  
			WHERE
			Status='Active' and
			@ProdSerialNmbrId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([SerialNumber], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@SerialNumber, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@ProdSerialNmbrId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO  [invnt].[ProductSerialNumbers] (
			       [ProdSerialNmbrKey]
				  ,[ProductId]
				  ,[SerialNumber]
				  ,[TagSupplierId]
				  ,[Remarks]
				  ,[SerialStatus]
				  
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
				@SerialNumber,
				@TagSupplierId,
				@Remarks,
				@SerialStatus, 

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
					  
					  [SerialNumber] = @SerialNumber,
					  [ProductId]=@ProductId,
					  [TagSupplierId]=@TagSupplierId,
					  [Remarks]=@Remarks,
					  [SerialStatus]=@SerialStatus,


					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [invnt].[ProductSerialNumbers] a WITH(ROWLOCK) 
					  WHERE 
					  a.ProdSerialNmbrId = @ProdSerialNmbrId 

					 SET @SuccessOrFailId = @ProdSerialNmbrId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]