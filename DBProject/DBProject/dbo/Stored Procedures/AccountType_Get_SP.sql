
 CREATE PROCEDURE [dbo].[AccountType_Get_SP](
 @LanguageId bigint
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	SELECT  [LanguageId]
      ,[AccTypeName]
  FROM [acc].[AccountTypes] where LanguageId=@LanguageId

  END