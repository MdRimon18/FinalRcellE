CREATE PROCEDURE [dbo].[Warehouse_InsertOrUpdate_SP](
   @WarehouseId bigint,
	@WarehouseKey uniqueidentifier= NULL,
	@WarehouseName nvarchar(300),
	@LocationId bigint,
	@ManagerName nvarchar(100)= NULL,
	@PhoneNumber nvarchar(20)= NULL,
	@Email nvarchar(100)= NULL,
	@Capacity int =NULL,
	@OperatingHours nvarchar(100) =NULL,
  @EntryDateTime DATETIME=NUll,
  @EntryBy BIGINT=NULL,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10)=NuLL,
  @SuccessOrFailId INT OUTPUT
) AS BEGIN 
      SET NOCOUNT ON;
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		-- Check if @unitName already exists (case-insensitive, trimmed, and with white spaces replaced)
		IF EXISTS (
			SELECT 1
			FROM  [stt].[Warehouse]
			WHERE
			Status='Active' and
			@WarehouseId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([WarehouseId], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@WarehouseId, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@WarehouseId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Warehouse] (
				   [WarehouseKey]
                  ,[WarehouseName]
                  ,[LocationId]
                  ,[ManagerName]
                  ,[PhoneNumber]
                  ,[Email]
                  ,[Capacity]
                  ,[OperatingHours]
				  ,[EntryDateTime]
				  ,[EntryBy]
				  ,[LastModifyDate]
				  ,[LastModifyBy]
				  ,[DeletedDate]
				  ,[DeletedBy]
				  ,[Status]
			   ) 
		VALUES (
				NEWID(),  
			
                @WarehouseName,
                 @LocationId,
                 @ManagerName,
                 @PhoneNumber,
                 @Email,
                @Capacity,
                @OperatingHours,
				@EntryDateTime,
				@EntryBy,
				@LastModifyDate,
				@LastModifyBy,
				@DeletedDate,
				@DeletedBy,
				'Active'
			);
			   SET @SuccessOrFailId = SCOPE_IDENTITY(); --Get Newly Created Id
             --  SELECT  @BillingPlanId AS BillingPlanId;  --Set Newly Created Id
			 
			  End
         Else
		   BEGIN TRY  --try start for update
					UPDATE 
					a WITH(ROWLOCK) 
					SET 
					  
					  
            [WarehouseName]=@WarehouseName,
               [LocationId]= @LocationId,
              [ManagerName] =@ManagerName,
               [PhoneNumber] = @PhoneNumber,
               [Email] = @Email,
              [Capacity] = @Capacity,
               [OperatingHours] =@OperatingHours,
					  
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					   [stt].[Warehouse] a WITH(ROWLOCK) 
					  WHERE 
					  a.WarehouseId = @WarehouseId 

					 SET @SuccessOrFailId = @WarehouseId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]