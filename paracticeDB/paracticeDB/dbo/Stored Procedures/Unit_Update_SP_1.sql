 
CREATE procedure [dbo].[Unit_Update_SP](
  @unitId BIGINT, 
  @unitKey uniqueidentifier=null,
  @branchId BIGINT = NULL,
  @unitName NVARCHAR(100), 
  @entryDateTime DATETIME=Null,
  @entryBy BIGINT=Null,
  @lastModifyDate DATETIME = NULL,
  @lastModifyBy BIGINT = NULL,
  @deletedDate DATETIME = NULL,
  @deletedBy BIGINT = NULL,
  @status VARCHAR(10) =null,
  @success INT OUTPUT
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
          [UnitName] = COALESCE(@unitName, [UnitName]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[Units] a WITH(ROWLOCK) 
		  WHERE 
		  a.UnitId = @unitId 

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Units]
