Create PROCEDURE [dbo].[PaymentTypes_Get_SP](
 @PaymentTypeId bigint=null,
 @PaymentTypeKey nvarchar(40)=null,
 @PaymentTypesName nvarchar(100)=null,
 @LanguageId Int=null,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[PaymentTypeId]
				  ,a.[PaymentTypeKey]
				  ,a.[LanguageId]
				  ,a.[PaymentTypesName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate] 
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.PaymentTypeId ASC) AS RowNum 
      FROM   [stt].[PaymentTypes] a
	  WHERE  (@PaymentTypeId IS NULL OR a.PaymentTypeId = @PaymentTypeId) and
	         (@PaymentTypeKey IS NULL OR a.PaymentTypeKey = @PaymentTypeKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@PaymentTypesName IS NULL OR a.PaymentTypesName = @PaymentTypesName)  
			 and a.Status='Active'
      )

		SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > ((@PageNumber - 1) * @PageSize) AND RowNum <= (@PageNumber * @PageSize)     
        ORDER BY 
        a.PaymentTypeId DESC;
  END