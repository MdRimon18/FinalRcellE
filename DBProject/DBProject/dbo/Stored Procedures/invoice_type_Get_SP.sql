

 Create PROCEDURE [dbo].[invoice_type_Get_SP](
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
      SET TRANSACTION isolation level READ uncommitted;

    

   WITH CTE AS  ( SELECT a.[InvoiceTypeId]
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
	   ,ROW_NUMBER() OVER (ORDER BY a.InvoiceTypeId ASC) AS RowNum 
	  
      FROM   [stt].[InvoiceTypes] a
	  WHERE  (@InvoiceTypeId IS NULL OR a.InvoiceTypeId = @InvoiceTypeId) and
	         (@InvoiceTypeKey IS NULL OR a.InvoiceTypeKey = @InvoiceTypeKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@InvoiceTypeName IS NULL OR  
			  LOWER(LTRIM(RTRIM(REPLACE(a.InvoiceTypeName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@InvoiceTypeName, ' ', ''))))  + '%')
			 and a.Status='Active'
      )
			 
    SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > (( @page_number - 1) * @page_size) AND RowNum <= ( @page_number * @page_size)     
        ORDER BY 
        a.InvoiceTypeName DESC;
  END  
  
 -- select * from  [stt].[InvoiceTypes]