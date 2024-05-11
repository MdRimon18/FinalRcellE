
Create PROCEDURE [dbo].[Menus_InsertOrUpdate_SP](
  @MenuId BIGINT, 
  @Menukey uniqueidentifier=null,
  @MenuName nvarchar (100),
  @MenuCode varchar (20)=NULL,
  @ParentMenuId int =NULL, 
  @PageUrl nvarchar (100) =NULL,
  @Action nvarchar (100) =NULL,
  @ActiveIcon nvarchar (100)= NULL,
  @LightIcon nvarchar (100)=NULL,
  @DarkIcon nvarchar (100) =NULL,
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
			FROM [stt].[Menus]  
			WHERE
			Status='Active' and
			@MenuId=0 and
			LOWER(LTRIM(RTRIM(REPLACE([MenuName], ' ', '')))) = LOWER(LTRIM(RTRIM(REPLACE(@MenuName, ' ', ''))))
		)
		BEGIN 
			-- If BillingPlanName already exists, set  @BillingPlanId to -1
			SET @SuccessOrFailId =-1;
		END
       ELSE
         BEGIN
		  IF(@MenuId=0)
			 Begin 
			  -- Insert new record
			  INSERT INTO [stt].[Menus] (
				   [Menukey]
				  ,[MenuName]
				  ,[MenuCode]
				  ,[ParentMenuId]
				  ,[PageUrl]
				  ,[Action]
				  ,[ActiveIcon]
				  ,[LightIcon]
				  ,[DarkIcon]
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
				@MenuName,
				@MenuCode,
				@ParentMenuId,
				@PageUrl,
				@Action,
				@ActiveIcon,
				@LightIcon,
				@DarkIcon,
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
					  [MenuName]= @MenuName,
					  [MenuCode] = @MenuCode,
					  [ParentMenuId] = @ParentMenuId,
					  [PageUrl] = @PageUrl,
				      [Action] = @Action,
					  [ActiveIcon] = @ActiveIcon,
					  [LightIcon] = @LightIcon,
					  [DarkIcon] = @DarkIcon,
								  
					  [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
					  [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
					  [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
					  [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
					  [Status] = COALESCE(@status, [Status])
					 FROM 
					  [stt].[Menus] a WITH(ROWLOCK) 
					  WHERE 
					  a.MenuId = @MenuId 

					 SET @SuccessOrFailId = @MenuId; -- Set success flag  updated Id
				 END TRY
				 BEGIN CATCH
					SET @SuccessOrFailId = 0; -- Error occurred, set success flag to 0
				 END CATCH
		 END 

		  
END;

--select * from [stt].[BillingPlans]