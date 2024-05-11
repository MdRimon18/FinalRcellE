


 Create PROCEDURE [dbo].[Country_Get_SP](
    @CountryId bigint=null,
	@CountryKey nvarchar=NULL,
	@LanguageId int, 
	@CountryName nvarchar(100)=NULL,
	@CntryShortName nvarchar(15),
	@CountryCode varchar(10)=NULL,
	@Capital varchar,
	@CurrencyId int,
	@CurrentArea decimal,
	@Population decimal,
    @page_number INT = 1,
    @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;


       WITH CTE AS (
      SELECT a.[CountryId]
      ,a.[CountryKey]
      ,a.[LanguageId]
      ,a.[CountryName]
	  ,a.[CntryShortName]
	  ,a.[CountryCode]
	  ,a.[Capital]
	  ,a.[CurrencyId]
	  ,a.[CurrentArea]
	  ,a.[Population]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]

	  ,ROW_NUMBER() OVER (ORDER BY a.CountryId ASC) AS RowNum 
      FROM   [stt].[Countries] a
	  WHERE  (@CountryId IS NULL OR a.CountryId = @CountryId) and
	         (@CountryKey  IS NULL OR a.CountryKey = @CountryKey) and
			 (@LanguageId  IS NULL OR a.LanguageId = @LanguageId) and
		     (@CountryName IS NULL OR a.CountryName = @CountryName) and
			  (@CntryShortName IS NULL OR a.CntryShortName = @CntryShortName)and
			  (@CountryCode IS NULL OR a.CountryCode = @CountryCode)and
		      (@Capital IS NULL OR a.Capital = @Capital)and
			  (@CurrencyId IS NULL OR a.CurrencyId= @CurrencyId) and
			  (@CurrentArea IS NULL OR a.CountryName = @CurrentArea)and
			 (@Population IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.CountryName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@CountryName, ' ', ''))))  + '%')
			 and a.Status='Active'
      )
     

		SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > ((@page_number - 1) * @page_size) AND RowNum <= (@page_number * @page_size)     
        ORDER BY 
        a.CountryId DESC;
  END 
  
 -- select * from  [invnt].[Units]