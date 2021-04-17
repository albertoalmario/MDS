--Limpia la cola de batch de MDM.
--Exec [mdm].[udpStagingBatchQueueActivate]

--Ver los Batch que se han enviado.
--Update mdm.tblStgBatch set status_id=7 where batchtag='SYNC-TBL-MDM-20160223102047300' and status_id=3
--Update mdm.tblStgBatch set status_id=7 where Entity_ID = 218 and status_id=3
