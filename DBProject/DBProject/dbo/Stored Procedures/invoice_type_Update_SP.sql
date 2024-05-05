

 
create procedure [dbo].[invoice_type_Update_SP](
  @InvoiceTypeId BIGINT, 
  @InvoiceTypeKey uniqueidentifier=null, 
  @InvoiceTypeName NVARCHAR(100),
  @LanguageId int,  
  @EntryDateTime DATETIME=null,
  @EntryBy BIGINT=null,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) =null,
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
		 
          [InvoiceTypeName] = COALESCE(@InvoiceTypeName, [InvoiceTypeName]),		 
		  [LanguageId] = COALESCE(@LanguageId, [LanguageId]),		  		 
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[InvoiceTypes] a WITH(ROWLOCK) 
		  WHERE 
		  a.InvoiceTypeId = @InvoiceTypeId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Currencies]