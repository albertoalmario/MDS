
/************ CONOCER LOS PROCESOS QUE NO SE PROCESARON Y GENERAN LENTITUD EN MDS ****************************/
 SELECT sb.ID ,sb.Entity_ID
FROM [mdm].tblStgBatch sb
INNER JOIN [mdm].tblEntity ent
ON sb.Entity_ID = ent.ID
WHERE sb.Status_ID != 3 --Running

/*********************** REALIZAR LA LIMPIEZA DE LOS PROCESOS EN BATCH CUANDO MDS ESTA LENTO *************************************/

DECLARE	@return_value int

EXEC	@return_value = [mdm].[udpEntityStagingBatchTableCleanup]

SELECT	'Return Value' = @return_value

GO

