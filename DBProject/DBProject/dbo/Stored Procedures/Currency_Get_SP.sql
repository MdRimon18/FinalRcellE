
 CREATE PROCEDURE [dbo].[Currency_Get_SP](
 @CurrencyId bigint=null,
 @CurrencyKey nvarchar(40)=null,
 @LanguageId int,
 @CurrencyName nvarchar(100)=null,
 @CurrencyCode varchar(10)=null,
 @CurrencyShortName nvarchar(15),
 @Symbol varchar(12),
 @ExchangeRate decimal,
 @BranchId Int=null,
 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      DECLARE @offset BIGINT
      SET @offset = (@page_number - 1) * @page_size;

      SELECT a.[CurrencyId]
      ,a.[CurrencyKey]
     
      ,a.[LanguageId]
      ,a.[CurrencyName]
      ,a.[CurrencyCode]
      ,a.[CurrencyShortName]
      ,a.[Symbol]
      ,a.[ExchangeRate]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]

      FROM   [stt].[Currencies] a
	  WHERE  (@CurrencyId IS NULL OR a.CurrencyId = @CurrencyId) and
	         (@CurrencyKey IS NULL OR a.CurrencyKey = @CurrencyKey) and
			 
			 (@CurrencyCode IS NULL OR a.CurrencyCode = @CurrencyCode) and
			(@CurrencyShortName IS NULL OR a.CurrencyShortName = @CurrencyShortName) and
			(@Symbol IS NULL OR a.Symbol = @Symbol) and
			(@ExchangeRate IS NULL OR a.ExchangeRate= @ExchangeRate) and
		    (@CurrencyName IS NULL OR a.CurrencyName = @CurrencyName)  
			 and a.Status='Active'
      ORDER  BY a.CurrencyId Desc

	 OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
  END 
  
 -- select * from  [stt].[currencies]
 
