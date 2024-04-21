
 CREATE PROCEDURE [dbo].[Language_Insert_SP](
  @LanguageId int OUTPUT, 
  @LanguageKey uniqueidentifier=null,

  @LanguageName NVARCHAR(100), 
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
			 FROM [stt].[Languages]  
			WHERE
			Status='Active' and
			LOWER(LTRIM(RTRIM(REPLACE([LanguageName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@LanguageName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @LanguageId  = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [stt].[Languages] (
				[LanguageKey],  

				[LanguageName],
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
			
				@LanguageName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @LanguageId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @LanguageId AS unitId;
END;
