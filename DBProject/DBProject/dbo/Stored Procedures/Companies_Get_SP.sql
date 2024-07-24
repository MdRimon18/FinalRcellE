

 CREATE PROCEDURE [dbo].[Companies_Get_SP](
 @CompanyId bigint=null,
 @CompanyKey nvarchar(40)=null,
 @CompanyName nvarchar(150)=null,
 @CompMobileNo nvarchar(100)=null,
 @CompanyEmail nvarchar(100)= NULL,
 @SearchValue nvarchar (150)=null,
 @CountryId bigint=null,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT  [CompanyId]
				  ,[CompanyKey]
				  ,[OwnerOrUserId]
				  ,[CompanyName]
				  ,[BusinessTypeId]
				  ,[CompMobileNo]
				  ,[CompanyEmail]
				  ,[CountryId]
				  ,[StateName]
				  ,[CompAddrss]
				  ,[CurrencyId]
				  ,[BillingPlanId]
				  ,[WorkingDays]
				  ,[StartToEndTime]
				  ,[CompanyLogoImgLink]
				  ,[IsHasBranch]
				  ,[EntryDateTime]
				  ,[EntryBy]
				  ,[LastModifyDate]
				  ,[LastModifyBy]
				  ,[DeletedDate]
				  ,[DeletedBy]
				  ,[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.CompanyId ASC) AS RowNum 
      FROM   [stt].[Companies] a
	  WHERE  (@CompanyId IS NULL OR a.CompanyId = @CompanyId) and
	         (@CompanyKey IS NULL OR a.CompanyKey = @CompanyKey) and
			 (@CompanyName IS NULL OR a.CompanyName = @CompanyName) and
			 (@CompMobileNo IS NULL OR a.CompMobileNo = @CompMobileNo) and
			 (@CompanyEmail IS NULL OR a.CompanyEmail = @CompanyEmail) and
			 (@CountryId IS NULL OR a.CountryId = @CountryId) and			
		     (@SearchValue IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.CompanyName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SearchValue, ' ', ''))))  + '%'
			 or
			 LOWER(LTRIM(RTRIM(REPLACE(a.CompMobileNo, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SearchValue, ' ', ''))))  + '%'
			 or
			 LOWER(LTRIM(RTRIM(REPLACE(a.CompanyEmail, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@SearchValue, ' ', ''))))  + '%' 
			-- or
			-- LOWER(LTRIM(RTRIM(REPLACE(a.CountryId, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@CountryId, ' ', ''))))  + '%'
			 
			
			 )
			
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
        a.CompanyId DESC;
  END