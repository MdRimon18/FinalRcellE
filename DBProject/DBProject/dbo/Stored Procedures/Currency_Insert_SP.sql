 CREATE PROCEDURE [dbo].[Currency_Insert_SP](
  @CurrencyId BIGINT OUTPUT, 
  @CurrencyKey uniqueidentifier=null,
 
  @CurrencyName NVARCHAR(100),
  @LanguageId int,
  @CurrencyCode varchar(10)=null,
  @CurrencyShortName nvarchar(15),
  @Symbol varchar(12),
  @ExchangeRate decimal,
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
			FROM [stt].[Currencies]  
			WHERE
			
			LOWER(LTRIM(RTRIM(REPLACE([CurrencyName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@CurrencyName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @CurrencyId= -1;
		END
       ELSE
         BEGIN
			-- Insert new record
		INSERT INTO [stt].[Currencies] (	
      [CurrencyKey],
      
      [LanguageId],
      [CurrencyName],
      [CurrencyCode],
      [CurrencyShortName],
      [Symbol],
      [ExchangeRate],
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
				@CurrencyName,
				@CurrencyCode,
				@CurrencyShortName,
				@Symbol,
				@ExchangeRate,
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				@Status
			);

			-- Get the unitId of the newly inserted record
			SET @CurrencyId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @CurrencyId AS CurrencyId;
END;
