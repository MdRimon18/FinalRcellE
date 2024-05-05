

 create PROCEDURE [dbo].[invoice_type_Get_SP](
 @InvoiceTypeId bigint=null,
 @InvoiceTypeKey nvarchar(40)=null,
 @InvoiceTypeName nvarchar(100)=null,
 @LanguageId Int,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[InvoiceTypeId]
      ,a.[InvoiceTypeKey]
      ,a.[LanguageId]
      ,a.[InvoiceTypeName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	  
      FROM   [stt].[InvoiceTypes] a
	  WHERE  (@InvoiceTypeId IS NULL OR a.InvoiceTypeId = @InvoiceTypeId) and
	         (@InvoiceTypeKey IS NULL OR a.InvoiceTypeKey = @InvoiceTypeKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@InvoiceTypeName IS NULL OR a.InvoiceTypeName = @InvoiceTypeName)  
			 and a.Status='Active'
      ORDER  BY a.InvoiceTypeId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [invnt].[Units]