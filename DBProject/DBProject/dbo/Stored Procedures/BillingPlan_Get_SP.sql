
 CREATE PROCEDURE [dbo].[BillingPlan_Get_SP](
 @BillingPlanId bigint=null,
 @BillingPlanKey nvarchar(40)=null,
 @BillingPlanName nvarchar(100)=null,
 @LanguageId Int=null,
 @PageNumber INT = 1,
 @PageSize INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;
 
	  WITH CTE AS (
				  SELECT a.[BillingPlanId]
				  ,a.[BillingPlanKey]
				  ,a.[LanguageId]
				  ,a.[BillingPlanName]
				  ,a.[EntryDateTime]
				  ,a.[EntryBy]
				  ,a.[LastModifyDate]
				  ,a.[LastModifyBy]
				  ,a.[DeletedDate]
				  ,a.[DeletedBy]
				  ,a.[Status]
				  ,ROW_NUMBER() OVER (ORDER BY a.BillingPlanId ASC) AS RowNum 
      FROM   [stt].[BillingPlans] a
	  WHERE  (@BillingPlanId IS NULL OR a.BillingPlanId = @BillingPlanId) and
	         (@BillingPlanKey IS NULL OR a.BillingPlanKey = @BillingPlanKey) and
			 (@LanguageId IS NULL OR a.LanguageId = @LanguageId) and
		     (@BillingPlanName IS NULL OR 
			 LOWER(LTRIM(RTRIM(REPLACE(a.BillingPlanName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@BillingPlanName, ' ', ''))))  + '%')
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
        a.BillingPlanId DESC;
  END