 create PROCEDURE [dbo].[Acc_Head_Insert_SP](
  @AccHeadId BIGINT OUTPUT, 
  @AccHeadKey uniqueidentifier=null,

  @AccHeadName NVARCHAR(100), 
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
			FROM [Acc].[AccHeads]  
			WHERE
			Status='Active' and
			
			LOWER(LTRIM(RTRIM(REPLACE([AccHeadName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@AccHeadName, ' ', ''))))
		)
		BEGIN
			-- If @unitName already exists, set @unitId to -1
			SET @AccHeadId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [Acc].[AccHeads] (
				[AccHeadKey],  
			
				[AccHeadName],
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
			
				@AccHeadName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @AccHeadId= SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @AccHeadId AS unitId;
END;

select * from [Acc]. AccHeads