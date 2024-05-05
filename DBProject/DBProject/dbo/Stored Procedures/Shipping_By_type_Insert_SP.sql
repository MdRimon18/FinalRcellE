

 Create PROCEDURE [dbo].[Shipping_By_type_Insert_SP](
  @ShippingById BIGINT OUTPUT, 
  @ShippingByKey uniqueidentifier=null,
  @ShippingByName NVARCHAR(100),
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
			FROM [stt].[ShippingBy] 
			WHERE
			
			LOWER(LTRIM(RTRIM(REPLACE([ShippingByName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@ShippingByName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @ShippingById= -1;
		END
       ELSE
         BEGIN
			-- Insert new record
		INSERT INTO [stt].[ShippingBy]  (	
      [ShippingByKey],      
      [LanguageId],
      [ShippingByName],   
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
				@ShippingByName,				
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				@Status
			);

			-- Get the unitId of the newly inserted record
			SET @ShippingById= SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @ShippingById AS ShippingById;
END;