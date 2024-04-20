 CREATE PROCEDURE [dbo].[Unit_Insert_SP](
  @unitId BIGINT OUTPUT, 
  @unitKey uniqueidentifier=null,
  @branchId BIGINT = NULL,
  @unitName NVARCHAR(100), 
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

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[Units]  
			WHERE
			Status='Active' and
			BranchId=@branchId and
			LOWER(LTRIM(RTRIM(REPLACE([UnitName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@unitName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @unitId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [stt].[Units] (
				[UnitKey],  
				[BranchId],
				[UnitName],
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
				@branchId,
				@unitName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @unitId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @unitId AS unitId;
END;


 