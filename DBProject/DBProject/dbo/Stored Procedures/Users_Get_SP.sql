

 Create PROCEDURE [dbo].[Users_Get_SP](
 @UserId bigint=null,
 @UserKey nvarchar(40)=null,
 @UserName nvarchar(100)= NUll,
 @UserPhoneNo nvarchar(100),
 @UserPassword nvarchar(20),
 @UserDesignation nvarchar(100)=NULL,
 @UserImgLink nvarchar(180)= NULL,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[UserId]
				  ,a.[UserKey]
				  ,a.[UserName]
				  ,a.[UserPhoneNo]
				  ,a.[UserPassword]
				  ,a.[UserDesignation]
				  ,a.[UserImgLink]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.UserId ASC) AS RowNum 
      FROM   [stt].[Users] a
	  WHERE  (@UserId IS NULL OR a.UserId = @UserId) and
	         (@UserKey IS NULL OR a.UserKey = @UserKey) and
			 (@UserName IS NULL OR a.UserName = @UserName) and
			 (@UserPhoneNo IS NULL OR a.UserPhoneNo = @UserPhoneNo) and
			 (@UserPassword IS NULL OR a.UserPassword = @UserPassword) and
			 (@UserDesignation IS NULL OR a.UserDesignation = @UserDesignation) and
			 (@UserImgLink IS NULL OR a.UserImgLink = @UserImgLink) and
		     (@UserName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.UserName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@UserName, ' ', ''))))  + '%')
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
        a.UserId DESC;
  END