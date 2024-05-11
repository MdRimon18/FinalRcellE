

 Create PROCEDURE [dbo].[Acc_Head_Get_SP](
 @AccHeadId bigint=null,
 @AccHeadKey nvarchar(40)=null,
 @AccHeadName nvarchar(100)=null,

 @page_number INT = 1,
 @page_size INT =10
 )
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted;

     
	 WITH CTE AS (
      SELECT a.[AccHeadId]
      ,a.[AccHeadKey]
      ,a.[AccHeadName]
      ,a.[EntryDateTime]
      ,a.[EntryBy]
      ,a.[LastModifyDate]
      ,a.[LastModifyBy]
      ,a.[DeletedDate]
      ,a.[DeletedBy]
      ,a.[Status]
	   ,ROW_NUMBER() OVER (ORDER BY a.AccHeadId ASC) AS RowNum
	  
      FROM   [Acc].[AccHeads] a
	  WHERE  (@AccHeadId IS NULL OR a.AccHeadId = @AccHeadId) and
	         (@AccHeadKey IS NULL OR a.AccHeadKey= @AccHeadKey) and
			
		     (@AccHeadName  IS NULL OR 
			  LOWER(LTRIM(RTRIM(REPLACE(a.AccHeadName, ' ', '')))) LIKE '%' + LOWER(LTRIM(RTRIM(REPLACE(@AccHeadName, ' ', ''))))  + '%')
			 and a.Status='Active'
      )

		SELECT 
			a.*,
			(SELECT COUNT(*) FROM CTE) AS total_row
		FROM   
        CTE a
        WHERE  
        RowNum > ((@page_number - 1) * @page_size) AND RowNum <= (@page_number * @page_size)     
        ORDER BY 
        a.AccHeadId DESC;
  END 
  
 -- select * from  [invnt].[Units]