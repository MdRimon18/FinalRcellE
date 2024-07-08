Create PROCEDURE [dbo].[EmailSetup_Get_SP](
 @EmailSetupId int=null,
 @EmailSetupkey nvarchar=NULL,
 @FromEmail nvarchar (150)=NULL,
 @FromName nvarchar (150)=NULL,
 @UserName nvarchar (150)=NULL,
 @Password nvarchar (500)=NULL,
 @PortNumber bigint=NULL,

 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[EmailSetupId]
				  ,a.[EmailSetupkey]
				  ,a.[FromEmail]
				  ,a.[FromName]
				  ,a.[UserName]
				  ,a.[Password]
				  ,a.[PortNumber]

				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.EmailSetupId ASC) AS RowNum 
      FROM    [stt].[EmailSetup] a
	  WHERE  (@EmailSetupId IS NULL OR a.EmailSetupId = @EmailSetupId) and
	         (@EmailSetupkey IS NULL OR a.EmailSetupkey = @EmailSetupkey) and
			 (@FromEmail IS NULL OR a.FromEmail = @FromEmail) and
			 (@FromName IS NULL OR a.FromName = @FromName) and
	         (@UserName IS NULL OR a.UserName = @UserName) and
			 (@Password IS NULL OR a.Password = @Password) and
			 (@PortNumber IS NULL OR a.PortNumber = @PortNumber) and
		     (@FromName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.FromName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@FromName, ' ', ''))))  + '%')
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
        a.EmailSetupId DESC;
  END