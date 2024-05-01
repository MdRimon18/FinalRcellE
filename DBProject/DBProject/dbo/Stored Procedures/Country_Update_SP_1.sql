 
 
CREATE procedure [dbo].[Country_Update_SP](
  @CountryId BIGINT, 
  @CountryKey nvarchar=NULL,
  @LanguageId int, 
  @CountryName NVARCHAR(100),
  @CountryCode varchar(10)=null,
  @CntryShortName nvarchar(15),
  @Capital varchar(100),
  @CurrencyId int,
  @CurrentArea decimal,
  @Population decimal,
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
		 
          [CountryName] = COALESCE(@CountryName, [CountryName]),
		 
		  [LanguageId] = COALESCE(@LanguageId, [LanguageId]),
		  [CountryCode ] = COALESCE(@CountryCode , [CountryCode]),
		  [CntryShortName] = COALESCE(@CntryShortName, [CntryShortName]),
		  [Capital] = COALESCE(@Capital, [Capital]),
		  [CurrencyId] = COALESCE(@CurrencyId, [CurrencyId]),
		  [CurrentArea] = COALESCE(@CurrentArea, [CurrentArea]),
		  [Population ] = COALESCE(@Population , [Population ]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[Countries] a WITH(ROWLOCK) 
		  WHERE 
		  a.CountryId = @CountryId

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Countries]