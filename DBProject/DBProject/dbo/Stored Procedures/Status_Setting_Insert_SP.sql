
 CREATE PROCEDURE [dbo].[Status_Setting_Insert_SP](
    @StatusSettingId BIGINT OUTPUT,
	@StatusSettingKey uniqueidentifier=NULL,
	@BranchId bigint,
	@StatusSettingName nvarchar(100),
	@PageName nvarchar(100),
	@Position int=NULL,
	@EntryDateTime datetime,
	@EntryBy bigint,
	@LastModifyDate datetime =NULL,
	@LastModifyBy bigint =NULL,
	@DeletedDate datetime =NULL,
	@DeletedBy bigint =NULL,
    @status VARCHAR(10) = 'Active'
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM [stt].[StatusSettings]  
			WHERE
			BranchId=@branchId and
			LOWER(LTRIM(RTRIM(REPLACE([StatusSettingName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@StatusSettingName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @StatusSettingId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [stt].[StatusSettings] (
				[StatusSettingKey],
                [BranchId],
                [StatusSettingName],
                [PageName],
                [Position],
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
				@StatusSettingName,
				@PageName,
		  	    @Position,
				
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @StatusSettingId= SCOPE_IDENTITY();
		END

-- Return the @unitId value
--SELECT @StatusSettingId AS unitId;
END;
