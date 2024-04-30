
 
CREATE procedure [dbo].[Currency_Update_SP](
  @CurrencyId BIGINT, 
  @CurrencyKey uniqueidentifier=null,
 
  @CurrencyName NVARCHAR(100),
  @LanguageId int,
  @CurrencyCode varchar(10)=null,
  @CurrencyShortName nvarchar(15),
  @Symbol varchar(12),
  @ExchangeRate decimal,
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
		 
          [CurrencyName] = COALESCE(@CurrencyName, [CurrencyName]),
		 
		  [LanguageId] = COALESCE(@LanguageId, [LanguageId]),
		  [CurrencyCode ] = COALESCE(@CurrencyCode , [CurrencyCode]),
		  [CurrencyShortName] = COALESCE(@CurrencyShortName, [CurrencyShortName]),
		  [Symbol] = COALESCE(@Symbol, [Symbol]),
		  [ExchangeRate] = COALESCE(@ExchangeRate, [ExchangeRate]),
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[Currencies] a WITH(ROWLOCK) 
		  WHERE 
		  a.CurrencyId = @CurrencyId 

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Currencies]

