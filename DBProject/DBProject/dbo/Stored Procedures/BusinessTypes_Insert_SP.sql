CREATE PROCEDURE [dbo].[BusinessTypes_Insert_SP](
  @businessTypeId BIGINT OUTPUT, 
  @businessTypeKey uniqueidentifier=null,
  @languageId BIGINT = NULL,
  @businessTypeName NVARCHAR(100), 
  @entryDateTime DATETIME,
  @entryBy BIGINT,
  @lastModifyDate DATETIME = NULL,
  @lastModifyBy BIGINT = NULL,
  @deletedDate DATETIME = NULL,
  @deletedBy BIGINT = NULL,
  @status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @businessTypeName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[BusinessTypes]  
			WHERE
			BusinessTypeId=@businessTypeId and
			LOWER(LTRIM(RTRIM(REPLACE([BusinessTypeName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@businessTypeName, ' ', ''))))
		)
		BEGIN
			-- If @businessTypeId already exists, set @businessTypeId to -1
			SET @businessTypeId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [stt].BusinessTypes(
				[BusinessTypeKey],  
				[LanguageId],
				[BusinessTypeName],
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
				@languageId,
				@businessTypeName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the  businessTypeId of the newly inserted record
			SET  @businessTypeId = SCOPE_IDENTITY();
		END

-- Return the  @businessTypeId value
SELECT  @businessTypeId AS  businessTypeId;
END;
--select * from [stt]. BusinessTypes