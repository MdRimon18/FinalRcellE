

 CREATE PROCEDURE [dbo].[Warehouse_Get_SP](
    @WarehouseId bigint,
	@WarehouseKey uniqueidentifier= NULL,
	@WarehouseName nvarchar(300),
	@LocationId bigint,
	@ManagerName nvarchar(100)= NULL,
	@PhoneNumber nvarchar(20)= NULL,
	@Email nvarchar(100)= NULL,
	@Capacity int =NULL,
	@OperatingHours nvarchar(100) =NULL,
    @PageNumber INT = 1,
    @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[WarehouseId]
                          ,a.[WarehouseKey]
                          ,a.[WarehouseName]
                          ,a.[LocationId]
                          ,a.[ManagerName]
                          ,a.[PhoneNumber]
                          ,a.[Email]
                          ,a.[Capacity]
                          ,a.[OperatingHours]
				          ,a.[EntryDateTime]
				          ,a.[EntryBy]
				          ,a.[LastModifyDate]
				          ,a.[LastModifyBy]
				          ,a.[DeletedDate]
				          ,a.[DeletedBy]
				          ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.WarehouseId ASC) AS RowNum 
      FROM   [stt].[Warehouse] a
	  WHERE  (@WarehouseId IS NULL OR a.WarehouseId = @WarehouseId) and
	         (@WarehouseKey IS NULL OR a.WarehouseKey = @WarehouseKey) and
			 (@WarehouseName IS NULL OR a.WarehouseName = @WarehouseName) and
			 (@LocationId IS NULL OR a.LocationId = @LocationId) and
	         (@ManagerName IS NULL OR a.ManagerName = @ManagerName) and
			 (@PhoneNumber IS NULL OR a.PhoneNumber = @PhoneNumber) and
			 (@Email IS NULL OR a.Email = @Email) and
	         (@Capacity IS NULL OR a.Capacity = @Capacity) and
			 (@OperatingHours IS NULL OR a.OperatingHours = @OperatingHours) and





		     (@WarehouseName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.WarehouseName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@WarehouseName, ' ', ''))))  + '%')
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
        a.WarehouseId DESC;
  END