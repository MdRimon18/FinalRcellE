

create PROCEDURE [dbo].[pr_tableDetails]
(
 @tableName NVARCHAR(200) 
)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
				SELECT 
			   c.name 'Column Name',			  
			   t.name,
			   t.name +
			   CASE WHEN t.name IN ('char', 'varchar','nchar','nvarchar') THEN '('+

						 CASE WHEN c.max_length=-1 THEN 'MAX'

							  ELSE CONVERT(VARCHAR(4),

										   CASE WHEN t.name IN ('nchar','nvarchar')

										   THEN  c.max_length/2 ELSE c.max_length END )

							  END +')'

					  WHEN t.name IN ('decimal','numeric')

							  THEN '('+ CONVERT(VARCHAR(4),c.precision)+','

									  + CONVERT(VARCHAR(4),c.Scale)+')'

							  ELSE '' END

			   as "DDL name",
			   c.max_length 'Max Length in Bytes',   
			   CASE WHEN c.is_nullable =0 THEN 'not null' ELSE 'null' END AS 'is_nullable',
			   ISNULL(i.is_primary_key, 0) 'Primary Key',
			   c.precision ,
			   c.scale ,
			   (SELECT name AS SchemaTable FROM sys.tables WHERE SCHEMA_NAME(schema_id)+'.'+name =@tableName) AS 'TableName'
			INTO #Temp
			FROM    
			   sys.columns c
			INNER JOIN 
			   sys.types t ON c.user_type_id = t.user_type_id
			LEFT OUTER JOIN 
			   sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
			LEFT OUTER JOIN 
			   sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
			WHERE
			   c.object_id = OBJECT_ID(@tableName)


			   Select 
			        
					'"'+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))+'":0,' AS 'JSON',				
					
					'@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  '+a.[DDL name]+',' AS 'Parametars', 
					'public  '+ CASE WHEN a.name = 'nvarchar' THEN 'string'
					                 WHEN a.name = 'bit' THEN (CASE WHEN a.is_nullable ='null' THEN 'bool?' ELSE 'bool' END) 
									 WHEN a.name = 'int' THEN (CASE WHEN a.is_nullable ='null' THEN 'int?' ELSE 'int' END) 
									 WHEN a.name = 'bigint' THEN (CASE WHEN a.is_nullable ='null' THEN 'long?' ELSE 'long' END) 
									 WHEN a.name = 'varchar' THEN 'string'
									 WHEN a.name = 'uniqueidentifier' THEN 'Guid'
									 WHEN a.name = 'datetime' THEN (CASE WHEN a.is_nullable ='null' THEN 'DateTime?' ELSE 'DateTime' END) 
									 WHEN a.name = 'float' THEN (CASE WHEN a.is_nullable ='null' THEN 'float?' ELSE 'float' END) 
									 WHEN a.name = 'numeric' THEN (CASE WHEN a.is_nullable ='null' THEN 'decimal?' ELSE 'decimal' END) 
					ELSE a.name END +'    '+a.[Column Name] +'  { get; set; }' AS 'Property',
					LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName]))) +'ViewModel.'+a.[Column Name]+'='+
					              CASE WHEN a.name ='bit' THEN '(bool)dr["'+a.[Column Name]+'"];'
								       WHEN a.name ='int' THEN 'Convert.ToInt32(dr["'+a.[Column Name]+'"].ToString());'
									   WHEN a.name ='bigint' THEN 'Convert.ToInt64(dr["'+a.[Column Name]+'"].ToString());'
									   --WHEN a.name ='datetime' THEN (CASE WHEN a.is_nullable ='null' THEN 'if(!string.IsNullOrEmpty(dr["'+a.[Column Name]+'"].ToString()) Convert.ToDateTime(dr["'+a.[Column Name]+'"].ToString());' ELSE 'Convert.ToDateTime(dr["'+a.[Column Name]+'"].ToString());' END) 
									   WHEN a.name ='datetime' THEN 'Convert.ToDateTime(dr["'+a.[Column Name]+'"].ToString());'
					                                          ELSE  'dr["'+a.[Column Name]+'"].ToString();' END AS 'GET',
					'prms[0].Value='+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName]))) +'ViewModel.'+a.[Column Name]+';' AS 'POST',		
				
				
					'DECLARE  @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName]))) 
					+'  TABLE ('
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name]   AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+')'
					+'  IF ( @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_xml' + ' IS NOT NULL)'+
	                  ' BEGIN' +
					  ' INSERT INTO @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+
					  ' ('+	(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  +', '+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+' )'
					+' SELECT   '+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+'doc.c.value( ''@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +''' ,' +''' '+g.[DDL name] +''' ) '+ LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )+' ) '
							+' FROM  @'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_xml.nodes'
							+'(' +'''/'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'/item'')doc(c) END' AS 'XML',

							   'INSERT INTO  '
					+@tableName				
					+' ('
					+ (SElect 	TOP 1	 
							STUFF  
							(  
								(  
								  SELECT  ', '+ CAST((LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' )' AS 'INSERT',
							





					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_set_update]'
					+'('
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name] + CASE WHEN g.is_nullable = 'null' THEN ' = null'ELSE ' ' END AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+')'
					+' AS 
					   BEGIN
							SET NOCOUNT ON
							SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED   '
					+'IF '+'(@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) + '= 0)        '
					+'BEGIN  '
                    +'INSERT INTO  '
					+@tableName				
					+'  VALUES ('
					+ (SElect 	TOP 1	 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' )'+
					+'  SET  '
					+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +' = '+ 'SCOPE_IDENTITY();'
					+ '    '+'SELECT '+'@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  '+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+'  END'
					+' ELSE  '
					+' 
					   BEGIN  
							'
                    +'UPDATE a  WITH(ROWLOCK) SET  '					
					+ (SElect 		 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name]+'=@'+LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+'  FROM  '+				
					+@tableName +' a'+' WITH(ROWLOCK) '
					+' WHERE a.'+a.[Column Name] +' = '+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+' END  '
					+'  END  '
					AS 'INSERT-UPDATE-PRO',









				
					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_set]'
					+'('
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name] + CASE WHEN g.is_nullable = 'null' THEN ' = null'ELSE ' ' END AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 )
							--Where t1.[Primary Key]=1)
					+')'
					+' AS 
					   BEGIN
							SET NOCOUNT ON
							SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED   '
                    +'INSERT INTO  '
					+@tableName				
					+'  VALUES ('
					+ (SElect 	TOP 1	 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name])))  AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' )'+
					+'  SET  '
					+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +' = '+ 'SCOPE_IDENTITY();'
					+ '    '+'SELECT '+'@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  '+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+'  END'
					AS 'INSERT-PRO',

					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_update]'
					+'('
					+(SElect 	 
							STUFF  
							(  
								(  
								  SELECT  ', '+'@'+ CAST(LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) +'  '+g.[DDL name] +CASE WHEN g.is_nullable = 'null' THEN ' = null'ELSE ' ' END AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+')'
					+' AS 
					   BEGIN
							SET NOCOUNT ON
							SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED   '
                    +'UPDATE a  WITH(ROWLOCK) SET  '					
					+ (SElect 		 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name]+'=@'+LOWER(LEFT(g.[Column Name],1))+(SUBSTRING(g.[Column Name],2,LEN(g.[Column Name]))) AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+'  FROM '+				
					+@tableName +' a'+' WITH(ROWLOCK) '
					+' WHERE a.'+a.[Column Name] +' = '+ '@'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+'  END'
					AS 'UPDATE-PRO'

					,
					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_get]'
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    '
					+'SELECT'
					+(SElect 	 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' FROM '
					+@tableName + ' a '
					+' ORDER BY ' + ' a.' +a.[Column Name]+' ASC '
					+' END '
					AS 'GET-PRO'
					,
						'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_get]'
					
					+' ( '
					+'@'+a.[Column Name] +'  '+a.[DDL name]+' =NULL'
					+' ) '
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    '
					+'SELECT'
					+(SElect 	 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' FROM '
					+@tableName + ' a '+
					' WHERE (@'+a.[Column Name]+' IS NULL OR a.'+a.[Column Name]+' = '+'@'+a.[Column Name]+' ) '
					+'AND a.Status =''Active'''
					+' ORDER BY ' + ' a.' +a.[Column Name]+' ASC '
					+' END '
					AS 'GET-AND-GETBY-PRO'
					,
							
					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_paging_wise_data_get]'
					
					+' ( '
					+' @page INT =1, '
					+' @page_size INT =10, '
					+' @searchtext NVARCHAR(500) = NULL '
					+' ) '
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    '
					+'SELECT a.'+a.[Column Name]
					+' INTO #temp1'
					+' FROM '
					+@tableName + ' a '+
					' WHERE (@searchtext  IS NULL OR a.'+a.[Column Name]+' = '+'@searchtext ) '
					+' ORDER BY ' + ' a.' +a.[Column Name]+' ASC '
					+'--Get paging record'
					+' SELECT TOP(@page_size) a.'+a.[Column Name]
					+' INTO #Temp2 '
					+' FROM  '
					+' ( '
					+' SELECT row_id = ROW_NUMBER() OVER (ORDER BY '+a.[Column Name]+ ' DESC),'+a.[Column Name]
					+' FROM #temp1 '
					+' ) a '
					+' WHERE a.row_id > ((@page-1)*@page_size) '
					+' -- GET DATA '
					+' SELECT '
					+(SElect 	 
							STUFF  
							(  
								(  
								 SELECT  +', '+'a.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' from  #Temp2 b '
					+'JOIN '+@tableName +' a ON a.'+a.[Column Name]+' = b.'+a.[Column Name]
					+' --Get total row '
					+' SELECT COUNT(*) AS total_row FROM #temp1 '
					+' END '
					AS 'GET-PAGING-WISE-DATA-GET-PRO'
					,

					'CREATE procedure [dbo].['+'pr_'+LOWER(LEFT(a.[TableName],1))+(SUBSTRING(a.[TableName],2,LEN(a.[TableName])))+'_get_list]'
					+' ( '
					+'  @tt_id tt_int READONLY  '
					+' ) '
					+' AS '
					+' BEGIN '
					+ 'SET NOCOUNT ON
	                   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	'
					+' CREATE TABLE  #' + LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) + ' ('+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +' INT )'
					+' INSERT INTO '+'#'+ LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) + ' ('+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +')'
					+'  SELECT  a.id'
	                 +  ' FROM @tt_id a  '
					+' SELECT '
					+(SElect TOP 1		 
							STUFF  
							(  
								(  
								 SELECT  +', '+'c.'+ CAST(g.[Column Name] AS VARCHAR(MAX))  
								  FROM #Temp g
								  FOR XMl PATH('')  
								),1,1,''  
							)  
							FROM #Temp t1 
							Where t1.[Primary Key]=1)
					+' FROM '
					+@tableName  + ' c '					
					+' JOIN '+
					+' #'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))+ ' a ' +'  ON '+'c.'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name]))) +'  = '+ 'a.'+LOWER(LEFT(a.[Column Name],1))+(SUBSTRING(a.[Column Name],2,LEN(a.[Column Name])))
					+' END '
					AS 'GET-LIST-PRO'

			   from #Temp a

	
END
