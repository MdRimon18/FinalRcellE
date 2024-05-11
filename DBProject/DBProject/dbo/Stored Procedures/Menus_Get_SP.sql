

  Create PROCEDURE [dbo].[Menus_Get_SP](
 @MenuId bigint=null,
 @Menukey nvarchar(40)=null,
 @MenuName nvarchar (100),
 @MenuCode varchar (20)=NULL,
 @ParentMenuId int =NULL, 
 @PageUrl nvarchar (100) =NULL,
 @Action nvarchar (100) =NULL,
 @ActiveIcon nvarchar (100)= NULL,
 @LightIcon nvarchar (100)=NULL,
 @DarkIcon nvarchar (100) =NULL,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[MenuId]
				  ,a.[Menukey]
				  ,a.[MenuName]
				  ,a.[MenuCode]
				  ,a.[ParentMenuId]
				  ,a.[PageUrl]
				  ,a.[Action]
				  ,a.[ActiveIcon]
				  ,a.[LightIcon]
				  ,a.[DarkIcon]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate] 
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.MenuId ASC) AS RowNum 
      FROM  [stt].[Menus] a
	  WHERE  (@MenuId IS NULL OR a.MenuId = @MenuId) and
	         (@Menukey IS NULL OR a.Menukey = @Menukey) and
			 (@MenuName IS NULL OR a.MenuName = @MenuName) and
			 (@MenuCode IS NULL OR a.MenuCode = @MenuCode) and
			 (@ParentMenuId IS NULL OR a.ParentMenuId = @ParentMenuId) and
			 (@PageUrl IS NULL OR a.PageUrl = @PageUrl) and
			 (@Action IS NULL OR a.Action = @Action) and
			 (@ActiveIcon IS NULL OR a.ActiveIcon = @ActiveIcon) and
			 (@LightIcon IS NULL OR a.LightIcon = @LightIcon) and
			 (@DarkIcon IS NULL OR 
		    
			 LOWER(LTRIM(RTRIM(REPLACE(a.MenuName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@MenuName, ' ', ''))))  + '%')
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
        a.MenuId DESC;
  END