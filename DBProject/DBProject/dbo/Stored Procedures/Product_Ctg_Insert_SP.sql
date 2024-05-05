
 Create PROCEDURE [dbo].[Product_Ctg_Insert_SP](
  @ProdCtgId BIGINT OUTPUT, 
  @ProdCtgKey uniqueidentifier=null,
  @BranchId BIGINT = NULL,
  @ProdCtgName NVARCHAR(100), 
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
			FROM [invnt].[ProductCategories]  
			WHERE
			Status='Active' and
			BranchId=@branchId and
			LOWER(LTRIM(RTRIM(REPLACE([ProdCtgName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@ProdCtgName, ' ', ''))))
		)
		BEGIN
			-- If @ProdCtgName already exists, set @ProdCtgId to -1
			SET @ProdCtgId = -1;
		END
       ELSE
         BEGIN
			-- Insert new record
			INSERT INTO [invnt].[ProductCategories] (
				[ProdCtgKey],  
				[BranchId],
				[ProdCtgName],
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
				@ProdCtgName,
				@entryDateTime,
				@entryBy,
				@lastModifyDate,
				@lastModifyBy,
				@deletedDate,
				@deletedBy,
				@status
			);

			-- Get the unitId of the newly inserted record
			SET @ProdCtgId = SCOPE_IDENTITY();
		END

-- Return the @unitId value
SELECT @ProdCtgId AS ProdCtgId;
END;

select * from [invnt]. ProductCategories