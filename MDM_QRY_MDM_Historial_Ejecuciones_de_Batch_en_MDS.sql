
SELECT B.ID AS Batch_ID, B.BatchTag, B.Status_ID 
,CASE B.Status_ID
WHEN 1 THEN 'QueuedToRun'
WHEN 3 THEN 'Running'
WHEN 4 THEN 'QueuedToClear'
WHEN 5 THEN 'Cleared'
WHEN 7 THEN 'Completed'
ELSE CONVERT(NVARCHAR(5),B.Status_ID) END AS Status_Description
,E.Model_ID, M.Name AS Model, B.Entity_ID, E.Name AS Entity, E.StagingBase, B.TotalMemberCount, B.ErrorMemberCount, B.EnterDTM, B.LastRunStartDTM, B.LastRunEndDTM, DATEDIFF(MINUTE,B.LastRunStartDTM, B.LastRunEndDTM) AS ExecutionTime_Minutes
,'SELECT ''' + E.Name + ''' AS Entity, * FROM stg.viw_' + E.StagingBase + '_MemberErrorDetails WHERE Batch_ID = ' + CONVERT(NVARCHAR(50),B.ID) + ' UNION ALL ' AS QRY
FROM mdm.tblStgBatch AS B 
LEFT JOIN mdm.tblEntity AS E ON B.Entity_ID = E.ID
INNER JOIN mdm.tblModel AS M ON E.Model_ID = M.ID
WHERE 1 = 1
--AND DATEDIFF(MINUTE,B.LastRunStartDTM, B.LastRunEndDTM) >= 10
AND B.EnterDTM >= '2017-10-26 00:00:00'
--AND E.Model_ID = 6 --Filtra modelo
--AND CONVERT(DATE,B.EnterDTM,7) = CONVERT(DATE,GETDATE(),7) --Filtra solo las ejecuciones del dia actual
ORDER BY B.ID DESC