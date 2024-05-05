  Create PROCEDURE [dbo].[Role_Get_SP](
 @RoleId bigint=null,
 @Rolekey nvarchar(40)=null,
 @RoleName nvarchar(100)=null,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[RoleId]
				  ,a.[Rolekey]
				  ,a.[RoleName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate] 
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.RoleId ASC) AS RowNum 
      FROM   [stt].[Role] a
	  WHERE  (@RoleId IS NULL OR a.RoleId = @RoleId) and
	         (@Rolekey IS NULL OR a.Rolekey = @Rolekey) and
		     (@RoleName IS NULL OR a.RoleName = @RoleName)  
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
        a.RoleId DESC;
  END