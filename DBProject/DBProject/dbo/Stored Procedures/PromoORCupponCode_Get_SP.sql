
 CREATE PROCEDURE [dbo].[PromoORCupponCode_Get_SP](
    @PromoOrCuppnId bigint,
	@PromoOrCuppnKey uniqueidentifier= NULL,
	@PromoOrCuppnName nvarchar (100),
	@Code varchar (20),
	
	@MaxUses int = NULL,
	@RemainingUses int =NULL,
	@Description nvarchar (max) =NULL,
    @PageNumber INT = 1,
    @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a. [PromoOrCuppnId]
      ,a.[PromoOrCuppnKey]
      ,a.[PromoOrCuppnName]
      ,a.[Code]
      ,a.[Discount]
      ,a.[ValidFrom]
      ,a.[ValidTo]
      ,a.[MaxUses]
      ,a.[RemainingUses]
      ,a.[Description]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.PromoOrCuppnId ASC) AS RowNum 
      FROM  [stt].[PromoOrCuppnCode] a
	  WHERE  (@PromoOrCuppnId IS NULL OR a.PromoOrCuppnId = @PromoOrCuppnId) and
	         (@PromoOrCuppnKey IS NULL OR a.PromoOrCuppnKey = @PromoOrCuppnKey) and
			 (@PromoOrCuppnName IS NULL OR a.PromoOrCuppnName = @PromoOrCuppnName) and
			 (@Code IS NULL OR a.Code = @Code) and
	        
	         (@MaxUses IS NULL OR a.MaxUses = @MaxUses) and
			 (@RemainingUses IS NULL OR a.RemainingUses = @RemainingUses) and
			 (@Description IS NULL OR a.Description = @Description) and

		     (@PromoOrCuppnName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.PromoOrCuppnName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@PromoOrCuppnName, ' ', ''))))  + '%')
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
        a.PromoOrCuppnId DESC;
  END