
 
create procedure [dbo].[Acc_head_Update_SP](
  @AccHeadId BIGINT, 
  @AccHeadKey uniqueidentifier=null,
 
  @AccHeadName NVARCHAR(100), 
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
		  
          [AccHeadName] = COALESCE(@AccHeadName, [AccHeadName]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [Acc].[AccHeads] a WITH(ROWLOCK) 
		  WHERE 
		  a.AccHeadId = @AccHeadId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [Acc].[AccHeads]