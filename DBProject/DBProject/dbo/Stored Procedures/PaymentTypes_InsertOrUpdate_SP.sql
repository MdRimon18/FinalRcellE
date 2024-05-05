Create PROCEDURE [dbo].[PaymentTypes_InsertOrUpdate_SP](
  @PaymentTypeId BIGINT, 
  @PaymentTypeKey uniqueidentifier=null,
  @LanguageId BIGINT,
  @PaymentTypesName NVARCHAR(100), 
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
			FROM [stt].[PaymentTypes]  
			WHERE
			Status='Active' and
			@PaymentTypeId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([PaymentTypeId], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@PaymentTypeId, ' ', ''))))
		)
		BEGIN 
			-- If PaymentTypesName already exists, set  @PaymentTypeId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@PaymentTypeId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[PaymentTypes] (
				   [PaymentTypeKey]
				  ,[LanguageId]
				  ,[PaymentTypesName]
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
				@PaymentTypesName,
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				'Active'
			);
			   SET @SuccessOrFailId = SCOPE_IDENTITY(); --Get Newly Created Id
             --  SELECT  @PaymentTypeId AS PaymentTypeId;  --Set Newly Created Id
			 
			  End
         Else
		   BEGIN TRY  --try start for update
					UPDATE 
					a WITH(ROWLOCK) 
					SET 
					  
					  [PaymentTypesName] = @PaymentTypesName,
					  [LanguageId]=@LanguageId,
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[PaymentTypes] a WITH(ROWLOCK) 
					  WHERE 
					  a.PaymentTypeId = @PaymentTypeId
					 SET @SuccessOrFailId = @PaymentTypeId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[PaymentTypes]