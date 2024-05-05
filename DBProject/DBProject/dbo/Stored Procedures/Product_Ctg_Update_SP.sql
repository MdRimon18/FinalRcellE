
Create procedure [dbo].[Product_Ctg_Update_SP](
  @ProdCtgId BIGINT, 
  @ProdCtgKey uniqueidentifier=null,
  @BranchId BIGINT = NULL,
  @ProdCtgName NVARCHAR(100), 
  @EntryDateTime DATETIME=Null,
  @EntryBy BIGINT=Null,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) =null,
  @Success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		  [BranchId] = COALESCE(@branchId, [BranchId]),
          [ProdCtgName] = COALESCE(@ProdCtgName, [ProdCtgName]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [invnt].[ProductCategories] a WITH(ROWLOCK) 
		  WHERE 
		  a.ProdCtgId = @ProdCtgId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [invnt].[ProductCategories]