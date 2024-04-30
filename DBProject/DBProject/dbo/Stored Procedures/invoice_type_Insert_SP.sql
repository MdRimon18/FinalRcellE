
 create PROCEDURE [dbo].[invoice_type_Insert_SP](
  @InvoiceTypeId BIGINT OUTPUT, 
  @InvoiceTypeKey uniqueidentifier=null,
  @InvoiceTypeName NVARCHAR(100),
  @LanguageId int, 
  @EntryDateTime DATETIME,
  @EntryBy BIGINT,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[InvoiceTypes]  
			WHERE
			
			LOWER(LTRIM(RTRIM(REPLACE([InvoiceTypeName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@InvoiceTypeName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @InvoiceTypeId= -1;
		END
       ELSE
         BEGIN
			-- Insert new record
		INSERT INTO [stt].[InvoiceTypes] (	
      [InvoiceTypeKey],      
      [LanguageId],
      [InvoiceTypeName],   
      [EntryDateTime],
      [EntryBy],
      [LastModifyDate],
      [LastModifyBy],
      [DeletedDate],
      [DeletedBy],
      [Status]
	) 
			VALUES (
				NEWID(),  
			
				@LanguageId,
				@InvoiceTypeName,				
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				@Status
			);

			-- Get the unitId of the newly inserted record
			SET @InvoiceTypeId= SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @InvoiceTypeId AS InvoiceTypeId;
END;