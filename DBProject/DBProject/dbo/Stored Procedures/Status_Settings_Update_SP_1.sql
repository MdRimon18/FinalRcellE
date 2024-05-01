
 
CREATE procedure [dbo].[Status_Settings_Update_SP](
    @StatusSettingId bigint,
	@StatusSettingKey uniqueidentifier=NULL,
	@BranchId bigint,
	@StatusSettingName nvarchar(100),
	@PageName nvarchar(100),
	@Position int=NULL,
	@EntryDateTime datetime=null,
	@EntryBy bigint=null,
	@LastModifyDate datetime =NULL,
	@LastModifyBy bigint =NULL,
	@DeletedDate datetime =NULL,
	@DeletedBy bigint =NULL,
	@Status varchar(10) =NULL,
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
		  [BranchId] = @BranchId,
          [StatusSettingName] =@StatusSettingName,
		  [PageName ] = @PageName,
		  [Position ] = COALESCE(@Position  , [Position ]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[StatusSettings] a WITH(ROWLOCK) 
		  WHERE 
		  a.StatusSettingId = @StatusSettingId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Units]