

 CREATE PROCEDURE [dbo].[Locations_Get_SP](
 @LocationId bigint,
 @LocationKey uniqueidentifier= NULl,
 @LocationName nvarchar(300),
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[LocationId]
				  ,a.[LocationKey]
				  ,a.[LocationName]				 
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.LocationId ASC) AS RowNum 
      FROM    [stt].[Locations] a
	  WHERE  (@LocationId IS NULL OR a.LocationId = @LocationId) and
	         (@LocationKey IS NULL OR a.LocationKey = LocationKey) and
			 (@LocationName IS NULL OR a.LocationName = @LocationName) and
		     (@LocationName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.LocationName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@LocationName, ' ', ''))))  + '%')
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
        a.LocationId DESC;
  END