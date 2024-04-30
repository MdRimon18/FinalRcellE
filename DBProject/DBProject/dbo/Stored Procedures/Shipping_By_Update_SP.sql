


 
Create procedure [dbo].[Shipping_By_Update_SP](
  @ShippingById BIGINT, 
  @ShippingByKey uniqueidentifier=null, 
  @ShippingByName NVARCHAR(100),
  @LanguageId int,  
  @EntryDateTime DATETIME=null,
  @EntryBy BIGINT=null,
  @LastModifyDate DATETIME = NULL,
  @LastModifyBy BIGINT = NULL,
  @DeletedDate DATETIME = NULL,
  @DeletedBy BIGINT = NULL,
  @Status VARCHAR(10) =null,
  @success INT OUTPUT
)AS
 BEGIN 
	SET 
	NOCOUNT ON 
	SET 
  TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
  BEGIN TRY
		UPDATE 
		a WITH(ROWLOCK) 
		SET 
		 
          [ShippingByName] = COALESCE(@ShippingByName, [ShippingByName]),		 
		  [LanguageId] = COALESCE(@LanguageId, [LanguageId]),		  		 
          [LastModifyDate] = COALESCE(@lastModifyDate, [LastModifyDate]),
          [LastModifyBy] = COALESCE(@lastModifyBy, [LastModifyBy]),
          [DeletedDate] = COALESCE(@deletedDate, [DeletedDate]),
          [DeletedBy] = COALESCE(@deletedBy, [DeletedBy]),
          [Status] = COALESCE(@status, [Status])
		 FROM 
		  [stt].[ShippingBy] a WITH(ROWLOCK) 
		  WHERE 
		  a.ShippingById = @ShippingById

		  SET @success = 1; -- Set success flag to 1
     END TRY
     BEGIN CATCH
         SET @success = 0; -- Error occurred, set success flag to 0
     END CATCH
  END

 --select *   FROM [stt].[Currencies]