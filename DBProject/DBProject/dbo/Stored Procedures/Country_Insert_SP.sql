
 CREATE PROCEDURE [dbo].[Country_Insert_SP](
  @CountryId BIGINT OUTPUT, 
  @CountryKey nvarchar=NULL,
  @LanguageId int, 
  @CountryName NVARCHAR(100),
  @CountryCode varchar(10)=null,
  @CntryShortName nvarchar(15),
  @Capital varchar,
  @CurrencyId int,
  @CurrentArea decimal,
  @Population decimal,
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
			FROM [stt].[Countries]  
			WHERE
			
			LOWER(LTRIM(RTRIM(REPLACE([CountryName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@CountryName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @CountryId= -1;
		END
       ELSE
         BEGIN
			-- Insert new record
		INSERT INTO [stt].[Countries] (	
      [CountryKey],
      [LanguageId],
      [CountryName],
	  [CntryShortName],
      [CountryCode],
      [Capital],
      [CurrencyId],
      [CurrentArea],
	  [Population],
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
                 @CountryName,
                 @CountryCode,
                 @CntryShortName,
                 @Capital,
                 @CurrencyId,
                 @CurrentArea,
                 @Population,
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				@Status
			);

			-- Get the unitId of the newly inserted record
			SET @CountryId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @CountryId AS CountryId;
END;