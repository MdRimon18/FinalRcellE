

 Create PROCEDURE [dbo].[Customers_Get_SP](
 @CustomerId bigint=null,
 @CustomerKey nvarchar(40)=null,
 @CustomerName nvarchar(100)=null,
 @MobileNo nvarchar(100),
 @Email nvarchar(100)= NULL,
 @StateName nvarchar(100),
 @Occupation nvarchar(100),
 @OfficeName nvarchar(100),
 
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[CustomerId]
			       ,a.[CustomerKey]
				  ,a.[CustomerName]
				  ,a.[MobileNo]
				  ,a.[Email]
				  ,a.[StateName]
				  ,a.[Occupation]
                  ,a.[OfficeName]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.CustomerId ASC) AS RowNum 
      FROM   [stt].[Customers] a
	  WHERE  (@CustomerId IS NULL OR a.CustomerId = @CustomerId) and
	         (@CustomerKey IS NULL OR a.CustomerKey = @CustomerKey) and
			 (@MobileNo IS NULL OR a.MobileNo = @MobileNo) and
			 (@Email IS NULL OR a.Email = @Email) and
	         (@StateName IS NULL OR a.StateName = @StateName) and
			 (@Occupation IS NULL OR a.Occupation = @Occupation) and
			 (@OfficeName IS NULL OR a.OfficeName = @OfficeName) and
		     (@CustomerName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.CustomerName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@CustomerName, ' ', ''))))  + '%')
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
        a.CustomerId DESC;
  END