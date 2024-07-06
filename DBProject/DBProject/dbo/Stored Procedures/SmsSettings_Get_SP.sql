
 Create PROCEDURE [dbo].[SmsSettings_Get_SP](
 @SmsSttngId bigint=null,
 @SmsSttngKey nvarchar(40)=null,
 @Title nvarchar(150),
 @SenderName nvarchar(100)=null,
 @SmsCode nvarchar (100)=NULL,
 @UserName nvarchar (100)=NULL,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[SmsSttngId]
				  ,a.[SmsSttngKey]
				  ,a.[Title]
				  ,a.[SenderName]
				  ,a.[SmsCode]				 
				  ,a.[UserName]				
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.SmsSttngId ASC) AS RowNum 
      FROM   [stt].[SmsSettings] a
	  WHERE  (@SmsSttngId IS NULL OR a.SmsSttngId = @SmsSttngId) and
	         (@SmsSttngKey IS NULL OR a.SmsSttngKey = @SmsSttngKey) and
			 (@Title IS NULL OR a.Title = @Title) and
			 (@SenderName IS NULL OR a.SenderName = @SenderName) and
	         (@SmsCode IS NULL OR a.SmsCode = @SmsCode) and
			 (@UserName IS NULL OR a.UserName = @UserName) and
		     (@SenderName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.SenderName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SenderName, ' ', ''))))  + '%')
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
        a.SmsSttngId DESC;
  END